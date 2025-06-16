//
//  LandingPageView.swift
//  ServiceStand
//
//  Created by Justin on 2025-06-15.
//

import Foundation
import SwiftUI

struct BikeListView: View {
  
  @EnvironmentObject var stravaAuthService: StravaService
  @StateObject var bikeList: BikeList
  
  init(bikes: [Gear]? = nil) {
    _bikeList = StateObject(wrappedValue: BikeList(bikes ?? []))
  }
  
  var user: Athlete? {
    stravaAuthService.user
  }
  
  var body: some View {
    VStack {
      HStack {
        ProfileImageView(imageURL: stravaAuthService.user?.profileURL)
        Text(user?.firstname ?? "unknown")
        Spacer()
      }
      .padding(.horizontal)
      
      List {
        ForEach(bikeList.bikes) { bike in
          NavigationLink {
            BikeDetailView(bike: bike)
          } label: {
            BikeRow(bike: bike)
          }
        }
      }
      .frame(maxHeight: .infinity)
    
      Image("api_logo_pwrdBy_strava_horiz_orange")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(height: 20)
    }
    .padding(.top)
    
  }
}

#Preview {
  BikeListView(bikes: [Gear(id: "123", primary: true, name: "Bike Name", distance: 12345724, brandName: "BrandName", modelName: "Model", frameType: 3, description: "Some Description")])
    .environmentObject(StravaService())
}

struct BikeRow: View {
  
  let bike: Bike
  
  var body: some View {
    HStack {
      Text(bike.name)
      Spacer()
      Text("\(bike.distance, specifier: "%.0f")m")
    }
  }
}

struct ProfileImageView: View {
    let imageURL: URL?

    var body: some View {
        AsyncImage(url: imageURL) { phase in
          switch phase {
          case .success(let image):
            image
              .resizable()
              .scaledToFill()
              .frame(width: 50, height: 50)
              .clipShape(Circle())
              .overlay(
                Circle().stroke(Color.white, lineWidth: 4)
              )
              .shadow(radius: 7)
          case .empty, .failure:
            Image(systemName: "person.crop.circle.fill")
              .resizable()
              .scaledToFill()
              .frame(width: 50, height: 50)
              .foregroundColor(.gray)
          @unknown default:
            EmptyView()
          }
        }
    }
}
