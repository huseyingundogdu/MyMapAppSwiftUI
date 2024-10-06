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
            mapLayer
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                header
                    .padding()
                Spacer()
                locationsPreviewStack
            }
        }
        .sheet(item: $vm.sheetLocation) { location in
            LocationDetailView(location: location)
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
    
    private var mapLayer: some View {
        Map(position: $vm.position) {
            ForEach(vm.locations) { location in
                //Marker($0.name, coordinate: $0.coordinates)
                Annotation(location.name, coordinate: location.coordinates) {
                    LocationMapAnnotationView()
                        .scaleEffect(vm.selectedLocation == location ? 1 : 0.7)
                        .shadow(radius: 10)
                        .onTapGesture {
                            vm.showSelectedLocation(location: location)
                        }
                }
            }
        }
    }
    
    private var locationsPreviewStack: some View {
        ZStack {
            ForEach(vm.locations) { location in
                if vm.selectedLocation == location {
                    LocationPreviewView(location: location)
                        .padding()
                        .shadow(radius: 20)
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading)))
                }
            }
        }
    }
}
