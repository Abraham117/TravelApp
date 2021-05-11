//
//  ContentView.swift
//  Roadtripper
//
//  Created by Abraham Aldana on 4/28/21.
//

import SwiftUI
import CoreData
import MapKit
import Combine

struct ContentView: View {

    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 35.3503, longitude: -119.1025), latitudinalMeters: 10000, longitudinalMeters: 10000)
    @State var tracking: MapUserTrackingMode = .follow
    @State var manager = CLLocationManager()
    @StateObject var managerDelegate = locationDelegate()
    
    @State var showMain: Bool = false
    
    var body: some View {
       
        let locations = ModelData().locations
        
        ZStack {
            
            VStack {
                
                Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: true, userTrackingMode: $tracking, annotationItems: locations){ location in
                  
                        MapMarker(coordinate: location.locationCoordinate)
                    
                    
                }
                    .onAppear() {
                        manager.delegate = managerDelegate
                    }
                    .ignoresSafeArea()
                    .overlay(
            
            
                            
                HStack {
                    Spacer()
                    Button(action: {
                        showMain.toggle()
                    }, label: {
                        Image(systemName: "chevron.up.circle.fill")
                            .foregroundColor(Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.8))
                            .font(.title)
                            .padding(20)
                    }).shadow(color: .gray, radius: 10, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                }
                        ,alignment: .bottomTrailing)
            }
            ZStack{
                if showMain {
                    CategoryHome(showMain: $showMain)
//                        .padding(.top, 80)
                        .transition(.move(edge: .bottom))
                        .animation(.spring())
                
                }
            }.zIndex(2.0)
    
        }
        
//        MapView(coordinate: CLLocationCoordinate2D(latitude: 35.3503, longitude: -119.1025))
        
    }
}

class locationDelegate : NSObject, ObservableObject, CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
//        var userCoordinates : CLLocation
        
        if manager.authorizationStatus == .authorizedWhenInUse {
            print("authorized")
            manager.startUpdatingLocation()
//            userCoordinates = manager.location!
            
            
        }
        else {
            print("not authorized")
            manager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print("new location")
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
