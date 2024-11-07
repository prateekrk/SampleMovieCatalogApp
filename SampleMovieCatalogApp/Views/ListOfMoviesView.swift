//
//  ListOfMoviesView.swift
//  SampleMovieCatalogApp
//
//  Created by Prateek Kovalli on 29/10/24.
//

import SwiftUI

struct ListOfMoviesView: View {
    var movies: Movies
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
    }
}

#Preview {
    ListOfMoviesView(movies: [.example, .example])
}


