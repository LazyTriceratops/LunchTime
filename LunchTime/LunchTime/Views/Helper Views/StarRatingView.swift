//
//  StarRatingView.swift
//  LunchTime
//
//  Created by Devin Eror on 11/18/23.
//

import SwiftUI



struct StarRatingView: View {
    var rating: Double?
    var totalRatings: Int?
    
    var body: some View {
        HStack(spacing: 4) {
            Image("star")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 15)
            
            if let rating = rating {
                Text(String(rating))
            } else {
                Text("?")
            }
            
            Text("•")
            
            Text("(\(totalRatings ?? 0))")
                .foregroundStyle(.gray)
            
        }
    }
}



#Preview {
    StarRatingView(rating: 3, totalRatings: 55)
}
