//
//  ContentView.swift
//  LunchTime
//
//  Created by Devin Eror on 11/14/23.
//

import SwiftUI



struct ContentView: View {
    
    @State var searchText = ""
    @State var mapToggle = true
    
    @StateObject var spotsModel: SpotsModel
        
    var body: some View {
        ZStack {
            Color.gray
                .opacity(0.15)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                LunchTimeHeader(spotsModel: spotsModel, searchText: $searchText)
                
                if mapToggle {
                    MapView(spots: $spotsModel.spots)
                } else {
                    ListView(spots: $spotsModel.spots)
                }
            }
            
            VStack {
                Spacer()
                MapToggleButton(mapToggle: $mapToggle)
            }
            .ignoresSafeArea(.keyboard)
        }
    }
}



#Preview {
    ContentView(spotsModel: SpotsModel())
}
