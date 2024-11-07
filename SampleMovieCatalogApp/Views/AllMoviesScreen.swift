//
//  AllMoviesScreen.swift
//  SampleMovieCatalogApp
//
//  Created by Prateek Kovalli on 07/11/24.
//

import SwiftUI

struct AllMoviesScreen: View {
    @State var movies: Movies
    @State var sortBy: SortOptions
    var controller: MovieCatalogController
    var body: some View {
        VStack {
            Menu {
                ForEach(SortOptions.allCases, id: \.self) { each in
                    Button {
                        sortBasedOnChoosedValue(sortOption: each)
                    } label: {
                        Text(each.rawValue)
                    }
                }
            } label: {
                Label(sortBy.rawValue, systemImage: "chevron.down")
            }
            ListOfMoviesView(movies: movies)
        }
        .onAppear(perform: {
            sortBasedOnChoosedValue(sortOption: sortBy)
        })
    }

    @MainActor func sortBasedOnChoosedValue(sortOption: SortOptions) {
        sortBy = sortOption
        movies = controller.sortBasedOnOptions(option: sortOption)
    }
}

#Preview {
    AllMoviesScreen(movies: [.example, .example], sortBy: .byYear, controller: MovieCatalogController())
}
