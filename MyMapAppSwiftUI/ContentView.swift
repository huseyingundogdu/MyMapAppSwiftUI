//
//  ContentView.swift
//  MyMapAppSwiftUI
//
//  Created by Huseyin on 02/10/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LocationsView()
    }
}

#Preview {
    ContentView()
        .environmentObject(LocationsViewModel())
}
