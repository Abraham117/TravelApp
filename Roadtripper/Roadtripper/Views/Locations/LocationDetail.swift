//
//  LocationDetail.swift
//  Roadtripper
//
//  Created by Abraham Aldana on 4/28/21.
//

import SwiftUI
import MapKit
import CoreLocation

struct LocationDetail: View {
    
    @EnvironmentObject var modelData: ModelData
    
    var location: Location
    
    var locationIndex: Int {
            modelData.locations.firstIndex(where: { $0.id == location.id })!
        }
    
//    var userCoordinates : CLLocation
    @State var showRoute: Bool = false
    
    var body: some View {
        
        ScrollView {
            
            // Image
            HeaderImage(image: location.image)
            
            VStack(alignment:.leading) {
                Text(location.name)
                    .font(.title)
                
                HStack {
                    Text(location.state)
                        .font(.subheadline)
                        .fontWeight(.medium)
                    
                    Spacer()
                    
                    let thisLocation = CLLocation(latitude: location.coordinates.latitude, longitude: location.coordinates.longitude)
                    let userCoordinates = CLLocation(latitude: 35.3503, longitude: -119.1025)
                    
                    let distance = userCoordinates.distance(from: thisLocation) / 1609.344
                    
//                    distanceInMiles = distance/1609.344
                    
                    let distanceText = " \(String(format:"%.0f", distance)) "
                    
                    Text(distanceText + "miles away")
                        .font(.subheadline)
                        .fontWeight(.medium)
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                
                Text("Explore")
                    .font(.title3)
                    .fontWeight(.medium)
                    .padding(.top, 8)
//                    .padding(.bottom, )
                
                MapViewSmall(coordinate: location.locationCoordinate)
                                .ignoresSafeArea(edges: .top)
                                .frame(height: 500)
                    .cornerRadius(10)
//                    .shadow(radius: 10)
                
                //button
                Button(action: {
                    showRoute.toggle()
                }, label: {
                    Text("View Route")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                        .padding(20)
                })
                .padding(.horizontal, 20.0)
                .frame(width: 360)
                .background(Color(.systemBlue))
                .cornerRadius(10)
                .padding(.top, 16)
                
                
                
                Divider().padding(.top, 28)
                
                Text("About \(location.name)")
                    .font(.title3)
                    .fontWeight(.medium)
                    .padding(.top, 16)
                    .padding(.bottom, 4)
                
                Text(location.description)
                    .font(.body)
                    .fontWeight(.regular)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .lineLimit(nil)
                
                Divider().padding(.top, 28)
                
                HStack {
                    Text("Add to Favorites")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                    Spacer()
                    FavoriteButton(isSet: $modelData.locations[locationIndex].isFavorite)
                }.padding(.top, 20)
                
            }
            .padding()
            .offset(y: -50)
            
            
            
        }
        ZStack{
            if showRoute {
//                RouteView(location: location, showRoute: $showRoute)
                DirectionView(showRoute: $showRoute, location: location)
                    .padding(.top, 80)
                    .transition(.move(edge: .trailing))
                    .animation(.spring())
                    .frame(height: 860)
            
            }
        }.zIndex(3.0)
        
//        .navigationTitle(location.name)
//        .navigationBarTitleDisplayMode(.inline)
        
    }
}

//struct LocationDetail_Previews: PreviewProvider {
//    static var previews: some View {
////        static let modelData = ModelData()
//        let modelData = ModelData()
//        _ = CLLocation(latitude: 35.3503, longitude: -119.1025)
//
//        LocationDetail(location: modelData.locations[59])
//                    .environmentObject(modelData)
//    }
//}
