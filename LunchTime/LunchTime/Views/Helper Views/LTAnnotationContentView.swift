//
//  LTAnnotationContentView.swift
//  LunchTime
//
//  Created by Devin Eror on 11/21/23.
//

import SwiftUI



struct LTAnnotationContentView: View {
    @Binding var isSelected: Spot?
    @Binding var spot: Spot
    
    var body: some View {
        VStack {
            Spacer()
            if isSelected == spot {
                SpotCardView(spot: $spot, isFavorited: spot.favorite)
                    .padding(.bottom, 8)
            }
            
            ZStack {
                Image(systemName: "drop")
                    .resizable()
                    .foregroundStyle(.white)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                
                Image(systemName: "drop.fill")
                    .resizable()
                    .foregroundStyle((isSelected == spot) ? .allTrailsGreen : .gray)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 45, height: 45)
            }
            .rotationEffect(.init(degrees: 180))
            .onTapGesture {
                if isSelected == spot {
                    isSelected = nil
                } else {
                    isSelected = spot
                }
            }
        }
        .frame(height: 200)
    }
}
