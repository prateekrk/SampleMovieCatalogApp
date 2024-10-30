//
//  MovieDatabaseView.swift
//  SampleMovieCatalogApp
//
//  Created by Prateek Kovalli on 29/10/24.
//

import SwiftUI

struct MovieCatalogView: View {
    @State var searchQuery: String = ""
    @State var isSheetPresented = false
    @StateObject var movieDataStore = MovieDataStore()
    @State var moviesMatchingSearch = Movies()
    @StateObject var controller: MovieCatalogController = MovieCatalogController()

    var chooseBy = ["Year","Genre","Directors","Actors","All Movies"]
    var body: some View {
        NavigationStack {
            VStack {
                Divider()
                ZStack {
                    RoundedRectangle(cornerRadius: 15).foregroundColor(Color(UIColor.lightGray)).frame(maxWidth: .infinity, maxHeight: 50)
                    
                    HStack {
                        Image(systemName: "magnifyingglass")
                        TextField("Search Movies by title/genere/actor/director", text: $searchQuery).onChange(of: searchQuery) {
                            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
                                moviesMatchingSearch = controller.searchForMovie(searchQuery: searchQuery)
                            }
                        }
                    }
                    .padding()
                }
                Divider()
                ScrollView {
                    if searchQuery.isEmpty {
                        ForEach(chooseBy, id: \.self) { each in
                            ExpandableButtonView(movieViewModel: controller, text: each)
                        }
                    } else {
                        ForEach(moviesMatchingSearch, id: \.imdbID) { each in
                            NavigationLink(destination: MovieDetailView(movie: each)) {
                                MovieCardView(movieModel: MovieModel.convertToMovieCardMode(model: each), imageUrl: each.poster)
                            }
                        }
                    }
                }
                Spacer()
            }.navigationTitle("Movie Catalog")
            .padding()
            .task {
                do {
                    try await movieDataStore.saveMoviews()
                } catch {
                    fatalError("Failed to load movies")
                }
                do {
                    try await movieDataStore.loadMovies()
                    controller.movies = movieDataStore.movies
                    
                } catch let error {
                    fatalError(error.localizedDescription)
                }
            }
        }
    }
}

#Preview {
    MovieCatalogView()
}
