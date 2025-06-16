//
//  SceneDelegate.swift
//  ServiceStand
//
//  Created by Justin on 2025-06-15.
//

import Foundation

import Foundation
import UIKit

/**
 SceneDelegate to manage scene-based events
 */
class SceneDelegate: NSObject, UIWindowSceneDelegate, ObservableObject {
  
  @Published var uri: URL?
  
  func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
    if let context = URLContexts.first {
      uri = context.url
    }
  }
}
