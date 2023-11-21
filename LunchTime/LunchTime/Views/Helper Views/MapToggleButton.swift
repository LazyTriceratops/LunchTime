//
//  MapToggleButton.swift
//  LunchTime
//
//  Created by Devin Eror on 11/16/23.
//

import SwiftUI



struct MapToggleButton: View {
    @Binding var mapToggle: Bool
    @State var toggle = true
    
    var body: some View {
        Button(action: {
            
            toggle.toggle()
            mapToggle.toggle()
            
        }, label: {
            HStack {
                if toggle{
                    Image(systemName: "list.bullet")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30)
                    
                } else {
                    ZStack {
                        Image(systemName: "drop")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 35)
                        
                        Image(systemName: "circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 10, alignment: .top)
                            .font(.system(size: 32, weight: .heavy))
                            .offset(CGSize(width: 0, height: 4))
                    }
                    .rotationEffect(.init(degrees: 180))
                }
                
                Text(toggle ? "List" : "Map")
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
