//
//  BikeList.swift
//  ServiceStand
//
//  Created by Justin on 2025-06-15.
//

import Foundation

class BikeList: ObservableObject {

  @Published var bikes: [Bike]
  
  init(_ bikes: [Bike]) {
    self.bikes = bikes
  }
}
