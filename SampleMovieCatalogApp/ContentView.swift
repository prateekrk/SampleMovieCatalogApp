//
//  ContentView.swift
//  SampleMovieCatalogApp
//
//  Created by Prateek Kovalli on 29/10/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var scrumStore = MovieDataStore()
    var body: some View {
        MovieCatalogView()
    }
}

#Preview {
    ContentView()
}
