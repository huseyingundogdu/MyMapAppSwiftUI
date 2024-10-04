//
//  LocationsView.swift
//  MyMapAppSwiftUI
//
//  Created by Huseyin on 02/10/2024.
//

import SwiftUI
import MapKit


struct LocationsView: View {
    @EnvironmentObject private var vm: LocationsViewModel
    
    var body: some View {
        ZStack {
            Map(position: $vm.position) {
                ForEach(vm.locations) {
                    Marker($0.name, coordinate: $0.coordinates)
                }
            }
            
            VStack {
                header
                    .padding()
                    
                
                Spacer()
            }
        }
    }
}

#Preview {
    LocationsView()
        .environmentObject(LocationsViewModel())
}

extension LocationsView {
    private var header: some View {
        VStack {
            HStack {
                Button(action: vm.toggleIsShowingLocationsList) {
                    Text(vm.selectedLocation.cityName + ", " + vm.selectedLocation.name)
                        .font(.title2)
                        .fontWeight(.black)
                        .foregroundStyle(.primary)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .animation(.none, value: vm.selectedLocation)
                        .overlay(alignment: .leading) {
                            Image(systemName: "arrow.down")
                                .font(.headline)
                                .foregroundStyle(.primary)
                                .padding()
                                .rotationEffect(Angle(degrees: vm.isShowingLocationsList ? 180 : 0))
                        }
                }
            }
            if vm.isShowingLocationsList {
                LocationsListView()
            }
            
        }
        .background(.thickMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(radius: 20, y: 15)
    }
}
