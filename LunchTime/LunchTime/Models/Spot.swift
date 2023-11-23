//
//  Spot.swift
//  LunchTime
//
//  Created by Devin Eror on 11/17/23.
//

import Foundation



// MARK: - Spots
struct Spots: Codable {
    let results: [Spot]
    let status: String
}



// MARK: - Spot
struct Spot: Codable, Identifiable {
    let businessStatus: String?
    let geometry: Geometry
    let name: String
    let openingHours: OpeningHours?
    let photos: [Photo]?
    let placeID: String?
    let priceLevel: Int?
    let rating: Double?
    let reference, scope: String?
    let types: [String]?
    let userRatingsTotal: Int?
    let vicinity: String?
    
    var id: String = ""
    var favorite: Bool = false
    var distance: Double? = nil
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Spot.CodingKeys.self)
        
        self.businessStatus = try? container.decodeIfPresent(String.self, forKey: .businessStatus)
        self.geometry = try! container.decodeIfPresent(Geometry.self, forKey: .geometry)!
        self.name = try! container.decodeIfPresent(String.self, forKey: .name)!
        self.openingHours = try? container.decodeIfPresent(OpeningHours.self, forKey: .openingHours)
        self.photos = try? container.decodeIfPresent([Photo].self, forKey: .photos)
        self.placeID = try? container.decodeIfPresent(String.self, forKey: .placeID)
        self.priceLevel = try? container.decodeIfPresent(Int.self, forKey: .priceLevel)
        self.rating = try? container.decodeIfPresent(Double.self, forKey: .rating)
        self.reference = try? container.decodeIfPresent(String.self, forKey: .reference)
        self.scope = try? container.decodeIfPresent(String.self, forKey: .scope)
        self.types = try? container.decodeIfPresent([String].self, forKey: .types)
        self.userRatingsTotal = try? container.decodeIfPresent(Int.self, forKey: .userRatingsTotal)
        self.vicinity = try? container.decodeIfPresent(String.self, forKey: .vicinity)
        
        self.id = "\(reference!)-\(name)"
        
        if self.distance == nil {
            let location = self.geometry.location
            if let distance = LocationManager.shared.distanceTo(lat: location.lat, lng: location.lng) {
                self.distance = distance
            }
        }
    }
}



// MARK: - Geometry
struct Geometry: Codable {
    let location: Location
}



// MARK: - Location
struct Location: Codable, Hashable {
    let lat, lng: Double
}



// MARK: - Opening Hours
struct OpeningHours: Codable, Hashable {
    let openNow: Bool?
}



// MARK: - Photo
struct Photo: Codable, Hashable {
    let height: Int?
    let htmlAttributions: [String]?
    let photoReference: String?
    let width: Int?
}



extension Spot: Equatable {
    static func == (lhs: Spot, rhs: Spot) -> Bool {
        lhs.geometry == rhs.geometry &&
        lhs.name == rhs.name &&
        lhs.id == rhs.id
    }
}



extension Geometry: Hashable {
    static func == (lhs: Geometry, rhs: Geometry) -> Bool {
        lhs.location == rhs.location
    }
}
