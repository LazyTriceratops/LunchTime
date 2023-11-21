//
//  Endpoint.swift
//  LunchTime
//
//  Created by Devin Eror on 11/19/23.
//

import Foundation



fileprivate let apiKey = ""



enum Endpoint {
    typealias Location = (lat: Double, lng: Double, radius: Int)
    
    case nearby(location: Location)
    case search(query: String, location: Location)
    case photos(reference: String, maxWidth: Int)
    
    func createURL() -> URL? {
        let baseURL = "maps.googleapis.com"
        let basePath = "/maps/api/place"
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = baseURL
        
        switch self {
        case .nearby(location: let location):
            urlComponents.path = basePath + "/nearbysearch/json"
            urlComponents.queryItems = [
                URLQueryItem(name: "location", value: "\(location.lat),\(location.lng)"),
                URLQueryItem(name: "radius", value: String(location.radius)),
                URLQueryItem(name: "type", value: "restaurant"),
                URLQueryItem(name: "key", value: apiKey)
            ]
            
            return urlComponents.url
            
        case .search(query: let query, location: let location):
            urlComponents.path = basePath + "/textsearch/json"
            urlComponents.queryItems = [
                URLQueryItem(name: "query", value: query),
                URLQueryItem(name: "location", value: "\(location.lat),\(location.lng)"),
                URLQueryItem(name: "radius", value: String(location.radius)),
                URLQueryItem(name: "key", value: apiKey)
            ]
            
            return urlComponents.url
            
        case .photos(reference: let reference, maxWidth: let maxWidth):
            urlComponents.path = basePath + "/photo"
            urlComponents.queryItems = [
                URLQueryItem(name: "maxwidth", value: String(maxWidth)),
                URLQueryItem(name: "photo_reference", value: reference),
                URLQueryItem(name: "key", value: apiKey)
            ]
            
            return urlComponents.url
        }
    }
}
