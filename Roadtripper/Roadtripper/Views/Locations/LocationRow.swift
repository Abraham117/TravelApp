//
//  LocationRow.swift
//  Roadtripper
//
//  Created by Abraham Aldana on 4/28/21.
//

import SwiftUI

struct LocationRow: View {
    
    var location: Location
    
    var body: some View {
        
        HStack {
            location.image
                .resizable()
                .frame(width:50, height: 50)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                .overlay(Circle().stroke(Color.white, lineWidth: 1.5))
                .shadow(radius:8)
                .padding(5)
                .padding(.leading, 5)
            Text(location.name)
                .font(.headline)
            Spacer()
            
            if location.isFavorite {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            }
        }
    
    }
}

struct LocationRow_Previews: PreviewProvider {
    
    static var locations = ModelData().locations
    
    static var previews: some View {
        Group {
            LocationRow(location: locations[60])
            LocationRow(location: locations[61])
            LocationRow(location: locations[62])
        }
        .previewLayout(.fixed(width: 300, height: 70))

        
    }
}
