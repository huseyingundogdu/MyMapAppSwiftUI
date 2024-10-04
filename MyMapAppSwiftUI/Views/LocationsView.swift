//
//  LocationsView.swift
//  MyMapAppSwiftUI
//
//  Created by Huseyin on 02/10/2024.
//

import SwiftUI
import MapKit


struct LocationsView: View {
    @StateObject private var vm = LocationsViewModel()
    
    var body: some View {
        ZStack {
            Map(position: $vm.position) {
                ForEach(vm.locations) {
                    Marker($0.name, coordinate: $0.coordinates)
                }
            }
            
            VStack {
                ForEach(vm.locations) { location in
                    Text(location.name)
                        .onTapGesture {
                            vm.selectedLocation = location
                        }
                }
                Spacer()
            }
        }
    }
}

#Preview {
    LocationsView()
}
