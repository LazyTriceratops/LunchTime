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
        HStack {
            ForEach (0..<5) { star in
                if let rating = rating {
                    Image(systemName: "star.fill")
                        .foregroundStyle(star < Int(rating) ? .yellow : .gray)
                    
                } else {
                    Image(systemName: "star.fill")
                        .foregroundStyle(.gray)
                }
            }
            .frame(width: 15)
            
            Text("(\(totalRatings ?? 0))")
        }
    }
}



#Preview {
    StarRatingView(rating: 3, totalRatings: 55)
}
