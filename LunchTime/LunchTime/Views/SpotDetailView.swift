//
//  SpotDetailView.swift
//  LunchTime
//
//  Created by Devin Eror on 11/18/23.
//

import SwiftUI



struct SpotDetailView: View {
    @Binding var spot: Spot
    @Binding var selected: Bool
    @State var localSelected: Bool
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .foregroundStyle(.clear)
                
                let photo = spot.photos?.first
                    
                CacheAsyncImage(ref: photo?.photoReference,
                                width: photo?.width) { phase in
                    if case let .success(image) = phase {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding()
                        
                    } else {
                        Image(systemName: "building.2.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(.gray)
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.size.width * 0.9)
            
            Text(spot.name)
                .font(.title)
            
            Text(spot.vicinity ?? "")
            
            StarRatingView(rating: spot.rating, totalRatings: spot.userRatingsTotal)
            
            Text((spot.priceLevel != nil) ? String(repeating: "$", count: spot.priceLevel ?? 0) : "?")
            
            Text((spot.openingHours?.openNow != nil) ? ((spot.openingHours?.openNow)! ? "Open" : "Closed") : "unknown")
                .foregroundStyle((spot.openingHours?.openNow != nil) ? ((spot.openingHours?.openNow)! ? .green : .red) : .gray) // Todo: clean up
            
            Button {
                localSelected.toggle()
                selected.toggle()
                spot.favorite = selected
                
            } label: {
                Image(localSelected ? "bookmark-saved" : "bookmark-resting")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .foregroundStyle(localSelected ? .allTrailsGreen : .gray)
                    .padding()
            }

            Spacer(minLength: 100)
        }
        .padding(.top, 50)
    }
}

#Preview {
    @State var spot = Spot()
    return SpotDetailView(spot: $spot, selected: $spot.favorite, localSelected: spot.favorite)
}
