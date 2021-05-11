//
//  CategoryHome.swift
//  Roadtripper
//
//  Created by Abraham Aldana on 5/3/21.
//

import SwiftUI

//import MapKit

struct CategoryHome: View {
    
    @EnvironmentObject var modelData: ModelData
//    @Environment(\.presentationMode) var presentationMode
    @Binding var showMain: Bool
    
    var body: some View {
        ZStack {
            VStack {
            
                NavigationView {

                    List {
                    
                        modelData.features[0].image
                            .resizable()
//                            .scaledToFill()
                            .frame(width: 392, height: 360)
                            .clipped()
                            .ignoresSafeArea()
                            .listRowInsets(EdgeInsets())
                        
                        ForEach(modelData.categories.keys.sorted(), id: \.self) { key in
                            
                            CategoryRow(categoryName: key, items: modelData.categories[key]!)
                        }
                        .listRowInsets(EdgeInsets())
                    }
        //        .listStyle(InsetListStyle())
                .navigationTitle("Explore")
                
                
                    
                }.overlay(
                    HStack {
                        Spacer()
                        Button(action: {
                            showMain.toggle()
                        }, label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(Color(red: 0.10, green: 0.10, blue: 0.10, opacity: 0.8))
                                .font(.title2)
                                .padding(20)
                                .offset(y:-10)
                        })
                    }
                    ,alignment: .topTrailing
                )
                
                
            }.cornerRadius(15)
            .shadow(color: .gray, radius: 20, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 5.0)
//                .padding(.top, 4)
//            .padding(.vertical, 6)
//            .background(
//                RoundedRectangle(
//                    cornerRadius: 30,
//                    style: .continuous
//                )
//                .fill(Color.white))
            
        }.offset(y: 30)
    }
}

struct CategoryHome_Previews: PreviewProvider {
    
    @State var showMain: Bool = false
    
    static var previews: some View {
        CategoryHome( showMain: .constant(false) )
            .environmentObject(ModelData())
    }
}
