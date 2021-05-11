//
//  HeaderImage.swift
//  Roadtripper
//
//  Created by Abraham Aldana on 4/28/21.
//

import SwiftUI

struct HeaderImage: View {
    
    var image: Image
    
    var body: some View {
        image
            .resizable()
            .frame(width: 392, height: 430)
            .offset(y: -50)
            .shadow(radius: 10)
    }
  
}

struct HeaderImage_Previews: PreviewProvider {
    static var previews: some View {
        HeaderImage(image: Image("seattle"))
    }
}
