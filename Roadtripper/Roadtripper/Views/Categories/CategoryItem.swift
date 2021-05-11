//
//  CategoryItem.swift
//  Roadtripper
//
//  Created by Abraham Aldana on 5/3/21.
//

import SwiftUI

struct CategoryItem: View {
    
    var location: Location
    
    var body: some View {
        VStack(alignment: .leading) {
                    location.image
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: 155, height: 155)
                        .cornerRadius(5)
                    Text(location.name)
                        .foregroundColor(.primary)
                        .font(.caption)
                }
                .padding(.leading, 15)
    }
}

struct CategoryItem_Previews: PreviewProvider {
    static var previews: some View {
        CategoryItem(location: ModelData().locations[59])
    }
}
