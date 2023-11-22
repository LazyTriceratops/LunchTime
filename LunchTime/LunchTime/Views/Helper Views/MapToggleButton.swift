//
//  MapToggleButton.swift
//  LunchTime
//
//  Created by Devin Eror on 11/16/23.
//

import SwiftUI



struct MapToggleButton: View {
    @Binding var mapToggle: Bool
    
    var body: some View {
        Button(action: {
            
            mapToggle.toggle()
            
        }, label: {
            HStack {
                    Image(mapToggle ? "list" : "map")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30)
                        .foregroundStyle(.white)
                
                Text(mapToggle ? "List" : "Map")
                    .font(.system(.title))
            }
            .frame(width: 100, height: 28)
            .padding()
        })
        .buttonStyle(MapToggleButtonStyle())
        .padding(.bottom, 30)
    }
}



private struct MapToggleButtonStyle: ButtonStyle {
    @ViewBuilder
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(.white)
            .background(.allTrailsGreen)
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }
}
