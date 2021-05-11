//
//  LocationList.swift
//  Roadtripper
//
//  Created by Abraham Aldana on 4/28/21.
//

import SwiftUI

struct LocationList: View {
   
    @EnvironmentObject var modelData: ModelData
    @State private var showFavoritesOnly = false
    
    var filteredLocations: [Location] {
        modelData.locations.filter { location in
                (!showFavoritesOnly || location.isFavorite)
            }
        }
    
    var body: some View {
        VStack {
            NavigationView {
                List {
                    
                    Toggle(isOn: $showFavoritesOnly) {
                                        Text("Favorites only")
                                    }
                    
                    ForEach(filteredLocations) { location in
                        
                        NavigationLink(destination: LocationDetail(location: location)) {
                            LocationRow(location: location)
                        }
                    }
                }
                .navigationTitle("All Locations")
            }
        
        }
    }
}

struct LocationList_Previews: PreviewProvider {
    static var previews: some View {
        LocationList()
            .environmentObject(ModelData())
    }
}
