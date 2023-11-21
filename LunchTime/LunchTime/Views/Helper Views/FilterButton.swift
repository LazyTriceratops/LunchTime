//
//  FilterButton.swift
//  LunchTime
//
//  Created by Devin Eror on 11/19/23.
//

import SwiftUI



struct FilterButton: View {
    @Binding var isFiltering: Bool
    @Binding var filterStyle: SpotFilter
    var filterOption: SpotFilter
    var text: String
    
    var body: some View {
        Button {
            
            filterStyle = filterOption

        } label: {
            HStack {
                ZStack {
                    Rectangle()
                        .foregroundStyle(.clear)
                    
                    if filterStyle == filterOption {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundStyle(.allTrailsGreen)
                    }
                }
                .frame(width: 25)
                
                Text(text)
                    .foregroundStyle(.black)
                Spacer()
            }
        }
    }
}
