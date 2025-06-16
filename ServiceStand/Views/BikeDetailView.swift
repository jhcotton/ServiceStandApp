//
//  BikeDetailView.swift
//  ServiceStand
//
//  Created by Justin on 2025-06-15.
//

import Foundation
import SwiftUI

struct BikeDetailView: View {
  
  var bike: Bike
  
  @State private var basicTune: Bool = false
  @State private var fullTune: Bool = false
  @State private var overhaul: Bool = false
  
  var body: some View {
    VStack{
      Text("\(bike.name)")
      
      List {
        Section(header: Text("Upcoming tasks")) {
          Toggle("Basic tune", isOn: $basicTune)
        }
        Section(header: Text("Future tasks")) {
          Toggle("Full tune", isOn: $fullTune)
          Toggle("Overhaul", isOn: $overhaul)
        }
      }
      .toggleStyle(.switch)
    }
  }
}

#Preview {
  BikeDetailView(bike: Bike(id: "1235", primary: true, name: "First Bike", distance: 23452, brandName: "Brand", modelName: "Model", frameType: 3, description: "Something"))
}
