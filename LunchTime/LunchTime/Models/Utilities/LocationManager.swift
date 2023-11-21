//
//  LocationManager.swift
//  LunchTime
//
//  Created by Devin Eror on 11/15/23.
//

import CoreLocation



class LocationManager: NSObject, ObservableObject {
    static let shared = LocationManager()
    
    private let locationManager = CLLocationManager()
    
    @Published var currentLocation: CLLocation?
    
    override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func refreshLocation() {
        locationManager.startUpdatingLocation()
    }
}



extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let local = locations.first else { return }
        
        self.currentLocation = local
        locationManager.stopUpdatingLocation()
    }
}
