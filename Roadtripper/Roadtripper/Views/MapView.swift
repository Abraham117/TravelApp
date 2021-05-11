//
//  MapView.swift
//  Roadtripper
//
//  Created by Abraham Aldana on 4/28/21.
//

import SwiftUI
import MapKit
import Combine

struct MapView: View {
    
    var coordinate: CLLocationCoordinate2D
    
    @State private var region = MKCoordinateRegion()
    @State var showMain: Bool = false
    

    
    var body: some View {
        
        ZStack {
            
            VStack {
                Map(coordinateRegion: $region)
                    .onAppear {
                        setRegion(coordinate)
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
                        })
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
    }
    
    private func setRegion(_ coordinate: CLLocationCoordinate2D) {
            region = MKCoordinateRegion(
                center: coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)
            )
    }
    
    

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(coordinate: CLLocationCoordinate2D(latitude: 47.6062, longitude: -122.3321))
        
    }
}

}
