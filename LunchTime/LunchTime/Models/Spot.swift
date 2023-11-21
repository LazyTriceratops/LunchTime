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
        self.favorite = false
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



extension Spot {
    /// Initialize Mock Data
    init() {
        self.businessStatus = "OPERATIONAL (barely)"
        self.geometry = Geometry(location: Location(lat: 34.0083, lng: -118.4988))
        self.name = "Bob's Burgers"
        self.openingHours = OpeningHours(openNow: true)
        self.photos = [Photo(height: nil, htmlAttributions: nil, photoReference: "AcJnMuGkOZeL3J5LHbYcB-f1xUpHD8t1FDHTPUX6Xag_ntX7hxuqqGs414B-IfbRXLcCeqUAMTGZ0x1ao8RBWTOhVu5M8DXVUctXqbRcYpqKnvThu6KY5uzkuKHJwszpUPEFHHwZg6bjgKKCHJzE2hBaNc5wjQ7gkBJgpFXYS4jgAGCwdJvN", width: 200)]
        self.placeID = "1234"
        self.priceLevel = 1
        self.rating = 5
        self.reference = ""
        self.scope = ""
        self.types = ["food"]
        self.userRatingsTotal = 1
        self.vicinity = "wonder wharf"
        self.favorite = true
    }
}
