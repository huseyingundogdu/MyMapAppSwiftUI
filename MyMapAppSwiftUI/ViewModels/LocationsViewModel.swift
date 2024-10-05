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
    
    @Published var isShowingLocationsList: Bool = false
    
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
    
    func toggleIsShowingLocationsList() {
        withAnimation(.easeInOut) {
            isShowingLocationsList = !isShowingLocationsList
        }
    }
    
    func showSelectedLocation(location: Location) {
        withAnimation(.easeInOut) {
            selectedLocation = location
            isShowingLocationsList = false
        }
    }
    
    func nextButtonPressed() {
        guard let currentIndex = locations.firstIndex(where: { $0 == selectedLocation }) else {
            print("Error: -nextButtonPressed()- current index")
            return
        }
        
        let nextIndex = currentIndex + 1
        
        guard locations.indices.contains(nextIndex) else {
            guard let firstLocation = locations.first else { return }
            showSelectedLocation(location: firstLocation)
            return
        }
        let nextLocation = locations[nextIndex]
        showSelectedLocation(location: nextLocation)
    }
}
