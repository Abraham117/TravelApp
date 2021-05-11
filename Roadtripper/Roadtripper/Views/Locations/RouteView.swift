//
//  RouteView.swift
//  Roadtripper
//
//  Created by Abraham Aldana on 5/10/21.
//

import SwiftUI
import MapKit
import Contacts


struct DirectionView: View {
    @State private var directions: [String] = []
    @State private var showDirections: Bool = false
    @Binding var showRoute: Bool
    
    var location: Location
    
    var body: some View {
        
            VStack{
                RouteView(location: location, directions: $directions)
                    .frame(height: 640)
                
                Button(action: {
                    self.showDirections.toggle()
                        }, label: {
                            Text("View Directions")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(Color.blue)
                                .multilineTextAlignment(.center)
                                .padding(20)
                        }).disabled(directions.isEmpty)
                Spacer()
//                        .padding(.horizontal, 20.0)
//                        .frame(width: 360)
//                        .background(Color(.systemBlue))
//                        .cornerRadius(10)
//                        .padding(.top, 16)
            }.sheet(isPresented: $showDirections, content: {
                VStack {
                    Text("Directions")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .bold()
                        .padding()
                    
                    Divider()
                    
                    List {
                        ForEach(0..<self.directions.count, id: \.self) { i in
                            Text(self.directions[i])
                                .padding()
                
                        }
                    }
                }
                
            } )
    }
}


struct RouteView: UIViewRepresentable {
    
    typealias UIViewType = MKMapView
    
    func makeCoordinator() -> MapViewCoordinator {
        return MapViewCoordinator()
    }
    
    var location: Location
    
//    @Binding var showRoute: Bool
    @Binding var directions: [String]
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.showsUserLocation = true;
        mapView.delegate = context.coordinator
        
        _ = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 35.3503, longitude: -119.1025),
            span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        
        //user location
//        let userCoordinates = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 35.3503, longitude: -119.1025))
        let userCoordinates = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: mapView.userLocation.coordinate.latitude, longitude: mapView.userLocation.coordinate.longitude))
        
        
//        let locationCoordinates = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 47.6062, longitude: -122.3321))
        let address = [CNPostalAddressCityKey: location.name, CNPostalAddressISOCountryCodeKey: ""]
        let locationCoordinates = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: location.coordinates.latitude, longitude: location.coordinates.longitude),addressDictionary: address)
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: userCoordinates)
        request.destination = MKMapItem(placemark: locationCoordinates)
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        directions.calculate{ response, error in
            guard let route = response?.routes.first else { return }
//            mapView.addAnnotations([userCoordinates,locationCoordinates])
            mapView.addAnnotation(locationCoordinates)
//            mapView.addAnnotation(userCoordinates)
            
//            let user = CLLocationCoordinate2D(latitude: 35.3503, longitude: -119.1025)
//            MapAnnotation(coordinate: user , anchorPoint: CGPoint(x: 0.5, y: 0.5)) {
//                Circle()
//                    .strokeBorder(Color.blue, lineWidth: 8)
//                    .frame(width: 25, height: 25)
//            }
                
                
            mapView.addOverlay(route.polyline)
            mapView.setVisibleMapRect(
                route.polyline.boundingMapRect,
                edgePadding: UIEdgeInsets(top: 50, left: 50, bottom: 100, right: 50),
                animated: true)
            self.directions = route.steps.map {$0.instructions}.filter{!$0.isEmpty}
        
        }
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
    
    class MapViewCoordinator: NSObject, MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = .systemBlue
            renderer.lineWidth = 5
            return renderer
        }
    }
    
}

//struct RouteView_Previews: PreviewProvider {
//    static var previews: some View {
//        RouteView(location: Location, showRoute: .constant(false))
//    }
//}

