//
//  MapViewSmall.swift
//  Roadtripper
//
//  Created by Abraham Aldana on 5/6/21.
//

import SwiftUI
import MapKit

struct MapViewSmall: View {
    
    var coordinate: CLLocationCoordinate2D
    
    @State private var region = MKCoordinateRegion()
    @State var showMain: Bool = false
    
    var body: some View {
        
        VStack {
            Map(coordinateRegion: $region, showsUserLocation: true)
                .onAppear {
                    setRegion(coordinate)
                }
                .ignoresSafeArea()
        }
        
    }
    
    private func setRegion(_ coordinate: CLLocationCoordinate2D) {
            region = MKCoordinateRegion(
                center: coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)
            )
    }
    
    

struct MapViewSmall_Previews: PreviewProvider {
    static var previews: some View {
        MapViewSmall(coordinate: CLLocationCoordinate2D(latitude: 47.6062, longitude: -122.3321))
        
    }
}

}
