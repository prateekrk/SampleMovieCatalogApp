//
//  ListOfMoviesView.swift
//  SampleMovieCatalogApp
//
//  Created by Prateek Kovalli on 29/10/24.
//

import SwiftUI

struct ListOfMoviesView: View {
    @StateObject var viewModel: MovieCatalogController
    @State var movies: Movies = []
    var selectedOption: SelectionValues?
    var selectedValue: String?
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach (movies, id: \.imdbID) { each in
                    NavigationLink(destination: MovieDetailView(movie: each)) {
                        MovieCardView(movieModel: MovieModel.convertToMovieCardMode(model: each), imageUrl: each.poster)
                    }
                }
            }
            .padding()
        }
        .onAppear {
            if selectedOption !=  nil, selectedValue != nil {
                movies = viewModel.getMoviesBySelectedValue(selectedOption: selectedOption!, value: selectedValue!)
            } else {
                movies = viewModel.movies
            }
        }
    }
}

#Preview {
    ListOfMoviesView(viewModel: MovieCatalogController(), movies: [.example, .example])
}


