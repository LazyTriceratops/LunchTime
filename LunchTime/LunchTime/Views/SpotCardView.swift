//
//  SpotCardView.swift
//  LunchTime
//
//  Created by Devin Eror on 11/17/23.
//

import SwiftUI



struct SpotCardView: View {
    @Binding var spot: Spot
    @State var isFavorited: Bool
    @State var isPresenting = false
    
    var body: some View {
        HStack {
            ZStack {
                Rectangle()
                    .foregroundStyle(.clear)
                
                let photo = spot.photos?.first
                
                CacheAsyncImage(ref: photo?.photoReference,
                                width: photo?.width) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        
                    case .failure(let error):
                        // log error
                        let _ = print(error)
                        Image(systemName: "building.2.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(.gray)
                        
                    case .empty:
                        ProgressView()
                        
                    @unknown default:
                        // log unknown
                        let _ = print("unknown")
                        
                    }
                }

            }
            .frame(width: 75, height: 75)
            
            VStack(alignment: .leading) {
                Text(spot.name)
                    .font(.title)
                    .minimumScaleFactor(0.5)
                
                StarRatingView(rating: spot.rating, 
                               totalRatings: spot.userRatingsTotal)
                
                HStack {
                    Text((spot.priceLevel != nil) ? String(repeating: "$", count: spot.priceLevel ?? 0) : "?")
                    Text("•")
                    Text((spot.openingHours?.openNow != nil) ? ((spot.openingHours?.openNow)! ? "Open" : "Closed") : "unknown") // TODO: clean up
                }
                .font(.subheadline)
                .foregroundStyle(.gray)
            }
            
            Spacer()
            
            VStack {
                Button {
                    isFavorited.toggle()
                    spot.favorite = isFavorited
                    
                } label: {
                    Image(isFavorited ? "bookmark-saved" : "bookmark-resting")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                        .foregroundStyle(isFavorited ? .allTrailsGreen : .gray)
                        .padding()
                }
                
                Spacer()
            }
        }
        .padding()
        .frame(width: 375, height: 120)
        .background(.white)
        .cornerRadius(7.0)
        .shadow(radius: 3)
        .onTapGesture {
            isPresenting = true
        }
        .popover(isPresented: $isPresenting, content: {
            SpotDetailView(spot: $spot, selected: $isFavorited, localSelected: isFavorited)
        })
    }
}



#Preview {
    @State var spot = Spot()
    return SpotCardView(spot: $spot, isFavorited: spot.favorite)
}
