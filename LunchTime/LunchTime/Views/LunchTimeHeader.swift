//
//  LunchTimeHeaderView.swift
//  LunchTime
//
//  Created by Devin Eror on 11/16/23.
//

import SwiftUI



struct LunchTimeHeader: View {
    @StateObject var spotsModel: SpotsModel
    @Binding var searchText: String
    
    @State var isFiltering = false
    @State var filterStyle: SpotFilter = .none
    
    var body: some View {
        VStack {
            HStack {
                Image("TitleImage")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300)
            }
            
            HStack {
                Button("Filter") {
                    isFiltering = true
                }
                .padding(8)
                .overlay {
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .stroke(.gray, lineWidth: 0.5)
                }
                .foregroundStyle(.gray)
                .shadow(radius: 3)
                
                HStack {
                    TextField("Search for a restaurant", text: $searchText)
                        .bold()
                        .foregroundStyle(.gray)
                        .onSubmit {
                            spotsModel.textSearch(searchText: searchText)
                        }
                        .submitLabel(.done)
                        
                    Button(action: {
                        searchText = ""
                        spotsModel.restoreOrigionalResults()
                    }, label: {
                        if searchText != "" {
                            Image(systemName: "xmark.circle")
                                .foregroundStyle(.gray)
                        }
                    })
                    
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.allTrailsGreen)
                }
                .padding(8)
                .overlay {
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .stroke(.gray, lineWidth: 0.5)
                }
                .shadow(radius: 3)
            }
            .padding()
        }
        .padding(.top, 25)
        .padding(.horizontal, 16)
        .frame(width: UIScreen.main.bounds.width)
        .background(.white)
        .sheet(isPresented: $isFiltering, content: {
            Form {
                ForEach([
                    (SpotFilter.none, "No Filter"),
                    (SpotFilter.ratingHigh, "Rating Hight to Low"),
                    (SpotFilter.ratingLow, "Rating Low to High")
                ], id: \.0) { item in
                    FilterButton(isFiltering: $isFiltering,
                                 filterStyle: $filterStyle,
                                 filterOption: item.0,
                                 text: item.1)
                }
            }
            .presentationDetents([.medium])
        })
        .onChange(of: filterStyle, { oldValue, newValue in
            spotsModel.sortSpots(by: newValue)
        })
    }
}



enum SpotFilter {
    case none
    case ratingHigh
    case ratingLow
}



#Preview {
    @State var mockSearch = ""
    @ObservedObject var mockSpots = SpotsModel()
    mockSpots.spots.append(Spot())
    return LunchTimeHeader(spotsModel: mockSpots, searchText: $mockSearch)
}
