//
//  CategoryRow.swift
//  Roadtripper
//
//  Created by Abraham Aldana on 5/3/21.
//

import SwiftUI

struct CategoryRow: View {
    
    var categoryName: String
        var items: [Location]
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text(categoryName)
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 16)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(items) { location in
                        NavigationLink(destination: LocationDetail(location: location)) {
                            CategoryItem(location: location)
                        }
                    }
                }
            }
            .frame(height: 185)
            .padding(.bottom, 12)
        }
    }
}

struct CategoryRow_Previews: PreviewProvider {
    
    static var locations = ModelData().locations
    
    static var previews: some View {
        CategoryRow(
                   categoryName: locations[59].category.rawValue,
                   items: Array(locations.prefix(54))
               )
    }
}
