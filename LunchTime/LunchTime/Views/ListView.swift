//
//  ListView.swift
//  LunchTime
//
//  Created by Devin Eror on 11/16/23.
//

import SwiftUI



struct ListView: View {
    let gridItem = GridItem()
    @Binding var spots: [Spot]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [gridItem], spacing: 12) {
                Spacer()
                ForEach($spots, id: \.id) { $spot in
                    SpotCardView(spot: $spot, isFavorited: spot.favorite)
                }
                Spacer(minLength: 100)
            }
        }
    }
}



#Preview {
    @State var mockSpots = [Spot]()
    mockSpots.append(Spot())
    return ListView(spots: $mockSpots)
}
