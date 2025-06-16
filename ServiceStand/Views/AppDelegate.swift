//
//  AppDelegate.swift
//  ServiceStand
//
//  Created by Justin on 2025-06-15.
//

import Foundation
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate, ObservableObject {
  
  /**
   Register SceneDelegate to receive scene based events, specifically scene(_:openURLContexts)
   */
  func application(
          _ application: UIApplication,
          configurationForConnecting connectingSceneSession: UISceneSession,
          options: UIScene.ConnectionOptions
  ) -> UISceneConfiguration {
    
    let configuration = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
    if connectingSceneSession.role == .windowApplication {
      configuration.delegateClass = SceneDelegate.self
    }
    return configuration
  }
}
