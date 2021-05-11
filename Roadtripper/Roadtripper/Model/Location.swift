//
//  Location.swift
//  Roadtripper
//
//  Created by Abraham Aldana on 4/28/21.
//

import Foundation
import SwiftUI
import CoreLocation

struct Location: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
//    var park: String
    var state: String
    var description: String
    var isFavorite: Bool
    var isFeatured: Bool
    
    var category: Category
        enum Category: String, CaseIterable, Codable {
            case cities = "Cities"
            case nature = "Nature"
            case california = "California"
            case east = "East Coast"
            case west = "West Coast"
            case canada = "Canada"
        }
    
    private var imageName: String
    var image: Image {
        Image(imageName)
    }
    
    public var coordinates: Coordinates
    var locationCoordinate: CLLocationCoordinate2D {
            CLLocationCoordinate2D(
                latitude: coordinates.latitude,
                longitude: coordinates.longitude)
        }
    
    struct Coordinates: Hashable, Codable {
            var latitude: Double
            var longitude: Double
        }
    
    
}

