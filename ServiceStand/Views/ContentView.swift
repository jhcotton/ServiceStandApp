//
//  ContentView.swift
//  ServiceStand
//
//  Created by Justin on 2025-06-15.
//

import SwiftUI

struct ContentView: View {
  
  @EnvironmentObject var sceneDelegate: SceneDelegate
  @StateObject var stravaAuthService = StravaService()
  @State private var path = NavigationPath()
  
  var body: some View {
    
    NavigationStack(path: $path) {
      VStack {
        Group {
          if stravaAuthService.state == .authorized {
            Button("Continue as logged in user") {
              path.append("loggedInView")
            }
          } else {
            Button(action: {
              signInWithStrava()
            }) {
              Image("btn_strava_connect_with_orange")
                .resizable()
                .scaledToFit()
                .frame(height: 120)
            }
          }
        }
        .padding(.bottom, 20)
        
        Text("State: \(stravaAuthService.state)")
      }
      .padding()
      .onReceive(sceneDelegate.$uri) { uri in
        if let uri = uri {
          stravaAuthService.handleAuthCode(uri: uri)
        }
      }
      .onReceive(stravaAuthService.$state) { state in
        if state == .authorized {
          path.append("loggedInView")
        }
      }
      .navigationDestination(for: String.self) { value in
        if value == "loggedInView" {
          BikeListView()
            .environmentObject(stravaAuthService)
        }
      }
    }
  }
  
  func signInWithStrava() {
    let canOpenStravaApp = UIApplication.shared.canOpenURL(URL(string: StravaService.appAuthString)!)
    
    UIApplication.shared.open(stravaAuthService.authUrl(useAppForAuth: canOpenStravaApp), options: [:], completionHandler: nil)
  }
}

#Preview {
  ContentView()
    .environmentObject(SceneDelegate())
}
