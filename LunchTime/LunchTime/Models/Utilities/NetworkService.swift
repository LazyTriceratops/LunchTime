//
//  NetworkService.swift
//  LunchTime
//
//  Created by Devin Eror on 11/15/23.
//

import Foundation



// MARK: - LunchTime Errors
enum LTError: Error {
    case invalidURL
    case invaildResponse(String?)
    case invalidData
}



// MARK: - Network Service
class NetworkService {
    static let shared = NetworkService()

    // MARK: - URLSessions
    func fetchNearbyPlaces(lat: Double, lng: Double, radius: Int) async throws -> Spots {
        guard let url = Endpoint.nearby(location: (lat: lat, lng: lng, radius: radius)).createURL() else {
            throw LTError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        try checkStatus(response)
        
        return try decodeSpots(data)
    }
    
    func fetchSearchedPlace(_ query: String, location: (lat: Double, lng: Double), radius: Int) async throws -> Spots {
        guard let url = Endpoint.search(query: query, location: (lat: location.lat, lng: location.lng, radius: radius)).createURL() else {
            throw LTError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        try checkStatus(response)
        
        return try decodeSpots(data)
    }
    
    func photoURL(photoReference: String, maxWidth: Int) -> URL? {
        Endpoint.photos(reference: photoReference, maxWidth: maxWidth).createURL()
    }
    
    // MARK: - Utility Methods
    private func checkStatus(_ response: URLResponse) throws {
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw LTError.invaildResponse("\((response as? HTTPURLResponse)?.statusCode ?? 000)")
        }
        
        // Add further status checks here
    }
    
    private func decodeSpots(_ data: Data) throws -> Spots {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let results = try decoder.decode(Spots.self, from: data)

            return results
        } catch {
            throw LTError.invalidData
        }
    }
}
