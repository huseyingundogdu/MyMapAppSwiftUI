//
//  LocationsViewModel.swift
//  MyMapAppSwiftUI
//
//  Created by Huseyin on 02/10/2024.
//

import Foundation
import MapKit
import SwiftUI

class LocationsViewModel: ObservableObject {
    @Published var locations: [Location]
    @Published var selectedLocation: Location {
        didSet {
            updateMapCameraPosition(location: selectedLocation)
        }
    }
    @Published var position: MapCameraPosition = MapCameraPosition.automatic
    
    private let span = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
    
    init() {
        let locations = LocalDataService.locations
        self.locations = locations
        selectedLocation = locations[3]
        self.updateMapCameraPosition(location: selectedLocation)
    }
    
    
    private func updateMapCameraPosition(location: Location) {
        withAnimation(.easeInOut) {
            position = .region(MKCoordinateRegion(
                center: selectedLocation.coordinates,
                span: span))
        }
    }
}
