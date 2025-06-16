//
//  Gear.swift
//  ServiceStand
//
//  Created by Justin on 2025-06-15.
//

import Foundation

import Foundation

struct Gear: Codable, Identifiable {
  let id: String
  let primary: Bool
  let name: String
  let distance: Float
  let brandName: String?
  let modelName: String?
  let frameType: Int?
  let description: String?
}

typealias Bike = Gear
