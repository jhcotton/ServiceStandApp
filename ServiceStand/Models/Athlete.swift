//
//  Athlete.swift
//  ServiceStand
//
//  Created by Justin on 2025-06-15.
//

import Foundation

struct Athlete: Codable {
  let id: Int?
  let firstname: String
  let profile: String
  let bikes: [Gear]?
}

extension Athlete {
  var profileURL: URL {
    URL(string: profile)!
  }
}
