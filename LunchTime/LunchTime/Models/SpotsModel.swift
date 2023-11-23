//
//  SpotsModel.swift
//  LunchTime
//
//  Created by Devin Eror on 11/19/23.
//

import Foundation
import Combine



// TODO:
// -[ ]: Add in pagination (store results in spot archive)
// -[ ]: Add more filter options
//    -[ ]: price
//    -[ ]: distance
// -[ ]: Store favorites in dictionary and save with SwiftData

@MainActor
class SpotsModel: ObservableObject {
    private var origionalResults = [[Spot]]()
    private let networkService = NetworkService.shared
    private let locationManager = LocationManager.shared
    
    static let defaultSearchRadius = 5000
    
    @Published var spots = [Spot]()
    @Published var favoriteSpots = [String:Spot]()  // fill in with in swiftdata.
    
    var subscribers = [AnyCancellable]()
    
    init() {
        
        setupLocationSubscribers()
    }
    
    private func saveOrigionalResults() {
        if self.origionalResults.isEmpty {
            self.origionalResults.append(spots)
        }
    }
    
    func restoreOrigionalResults() {
        spots = origionalResults[0]
    }
    
    /// Sort locations based on the provided filter.
    func sortSpots(by filter: (SpotFilter)) {
        switch filter {
        case .none:
            if !origionalResults.isEmpty {
                spots = origionalResults[0]
            }
            
        case .ratingHigh:
            spots.sort { $0.rating ?? 0 > $1.rating ?? 0 }
            
        case .ratingLow:
            spots.sort { $0.rating ?? 0 < $1.rating ?? 0 }
        }
    }
}



// MARK: - Location Methods
extension SpotsModel {
    
    private func setupLocationSubscribers() {
        subscribers.append(locationManager.$currentLocation.sink(receiveValue: { location in
            guard let location = location else { return }
            
            self.nearbySearch(location: (lat: location.coordinate.latitude, lng: location.coordinate.longitude, radius: SpotsModel.defaultSearchRadius))
        }))
    }
}



// MARK: - Network Methods
extension SpotsModel {
    
    /// search based on provided location.
    func nearbySearch(location: (lat: Double, lng: Double, radius: Int)) {
        Task {
            do {
                let fetchedSpots = try await self.networkService.fetchNearbyPlaces(lat: location.lat, lng: location.lng, radius: location.radius)
                
                spots = fetchedSpots.results
                saveOrigionalResults()
                
            } catch(let error) {
                print(error)
            }
        }
    }
    
    /// search based on input text and current location.
    func textSearch(searchText: String) {
        guard let location = locationManager.currentLocation else { return }
        Task {
            do {
                let fetchedSpots = try await self.networkService.fetchSearchedPlace(searchText, location: (location.coordinate.latitude, location.coordinate.longitude), radius: 1500)
                
                spots = fetchedSpots.results
            } catch(let error) {
                print(error)
            }
        }
    }
}
