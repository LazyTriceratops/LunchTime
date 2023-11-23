//
//  MapView.swift
//  LunchTime
//
//  Created by Devin Eror on 11/16/23.
//

import MapKit
import SwiftUI



struct MapView: View {
    @Binding var spots: [Spot]
    @State var isSelected: Spot?
    
    @State private var position: MapCameraPosition = .automatic
    
    var body: some View {
        Map(position: $position) {
            
            UserAnnotation()
            
            ForEach($spots, id: \.id) { $spot in
                let location = CLLocationCoordinate2D(latitude: spot.geometry.location.lat, longitude: spot.geometry.location.lng)
                
                Annotation("", coordinate: location, anchor: .bottom) {
                    LTAnnotationContentView(isSelected: $isSelected, spot: $spot)
                }
            }
        }
        .mapStyle(.standard(
            elevation: .realistic,
            emphasis: .muted,
            pointsOfInterest: .all,
            showsTraffic: false))
        .mapControls({
            MapUserLocationButton()
        })
        // TODO: rework needed (Currently is too clunky on physical device).
//        .onChange(of: isSelected) {
//            if let coords = isSelected?.coord() {
//                withAnimation(.easeInOut) {
//                    position = .region(MKCoordinateRegion(center: coords, latitudinalMeters: 1600, longitudinalMeters: 1600))
//                }
//            }
//            else {
//                withAnimation(.easeOut) {
//                    position = .automatic
//                }
//            }
//        }
    }
}



extension Spot {
    func coord() -> CLLocationCoordinate2D? {
        CLLocationCoordinate2D(latitude: self.geometry.location.lat, longitude: self.geometry.location.lng)
    }
}



#Preview {
    @State var mockSpots = [Spot]()
    return MapView(spots: $mockSpots)
}
