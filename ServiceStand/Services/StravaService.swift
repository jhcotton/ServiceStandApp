//
//  StravaService.swift
//  ServiceStand
//
//  Created by Justin on 2025-06-15.
//

import Foundation

class StravaService: ObservableObject {
  
  @Published var accessToken: Token?
  @Published var state: State = .none
  @Published var user: Athlete?
  
  var scope: String = ""
  
  private let decoder: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return decoder
  }()
  
  func handleAuthCode(uri: URL) {
    // Check for error codes
    if let error = uri.valueOf("error") {
      error == "access_denied" ? (state = .access_denied) : (state = .error)
      return
    }
    
    // Use code to request token and also set the scope values
    if let code = uri.valueOf("code"), let scope = uri.valueOf("scope") {
      self.scope = scope
      Task { @MainActor in
        accessToken = try await requestToken(code: code)
        user = try await getLoggedInAthlete()
        state = .authorized
      }
    }
  }
  
  @MainActor
  private func requestToken(code: String) async throws -> Token {
    let tokenURL = URL(string: "https://www.strava.com/oauth/token")!
    var request = URLRequest(url: tokenURL)
    request.httpMethod = "POST"
    let body = "grant_type=authorization_code&code=\(code)&client_id=\(Environment.Strava.clientId)&client_secret=\(Environment.Strava.clientSecret)"
    
    request.httpBody = body.data(using: .utf8)
    
    let (data, _) = try await URLSession.shared.data(for: request)
    let tokenResponse = try decoder.decode(TokenResponse.self, from: data)
    
    return Token(type: tokenResponse.tokenType, value: tokenResponse.accessToken)
  }
}

extension StravaService {
  enum State {
    case none
    case authorized
    case access_denied
    case error
  }
}

extension StravaService {
  static let appAuthString = "strava://oauth/mobile/authorize"
  static let webAuthString = "https://www.strava.com/oauth/mobile/authorize"
  
  func authUrl(useAppForAuth: Bool) -> URL {
    var url = URLComponents(string: useAppForAuth ? Self.appAuthString : Self.webAuthString)!
    url.queryItems = [
      URLQueryItem(name: "client_id", value: Environment.Strava.clientId),
      URLQueryItem(name: "response_type", value: "code"),
      URLQueryItem(name: "redirect_uri", value: Environment.Strava.redirectURI),
      URLQueryItem(name: "approval_prompt", value: "force"),
      URLQueryItem(name: "scope", value: "profile:read_all")
    ]
    return url.url!
  }
}

// MARK: URL helper to extract value from params
extension URL {
  func valueOf(_ query: String) -> String? {
    guard let url = URLComponents(string: self.absoluteString) else { return nil }
    return url.queryItems?.first(where: { $0.name == query })?.value
  }
}

// MARK: API calls
extension StravaService {
  @MainActor
  func getLoggedInAthlete() async throws -> Athlete {
    guard let url = URL(string: "https://www.strava.com/api/v3/athlete"),
          let token = accessToken
    else { throw NSError(domain: "", code: 0, userInfo: nil) }
    
    var request = URLRequest(url: url)
    request.setValue("Bearer \(token.value)", forHTTPHeaderField: "Authorization")
    
    let (data, _) = try await URLSession.shared.data(for: request)
    let athlete = try decoder.decode(Athlete.self, from: data)
    return athlete
  }
}

// MARK: Strava Environment
struct Environment {
  struct Strava {
    static let clientId = "132133"
    static let clientSecret = "da2051bc2c07b3b15dbee49ff67ee0d0cc4b2b62"
    static let redirectURI = "ServiceStand://servicestand"
  }
}
