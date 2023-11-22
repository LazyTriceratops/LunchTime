//
//  LTAnnotationContentView.swift
//  LunchTime
//
//  Created by Devin Eror on 11/21/23.
//

import SwiftUI



struct LTAnnotationContentView: View {
    @Binding var isSelected: Spot? // TODO: pass in strings instead of Spot objects.
    @Binding var spot: Spot
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            if isSelected == spot {
                SpotCardView(spot: $spot)
            }
            
            Image((isSelected == spot) ? "pin-selected" : "pin-resting")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .onTapGesture {
                    if isSelected == spot {
                        isSelected = nil
                    } else {
                        isSelected = spot
                    }
                }
        }
    }
}
