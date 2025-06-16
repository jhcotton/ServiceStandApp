//
//  TokenResponse.swift
//  ServiceStand
//
//  Created by Justin on 2025-06-15.
//

struct TokenResponse: Codable {
  var tokenType: String
  var accessToken: String
  var athlete: Athlete
}
