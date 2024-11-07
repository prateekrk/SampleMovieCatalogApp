//
//  MovieDatabaseView.swift
//  SampleMovieCatalogApp
//
//  Created by Prateek Kovalli on 29/10/24.
//

import SwiftUI

struct MovieCatalogView: View {
    @State var searchQuery: String = ""
    @State var isLoading = true
    @State var isSheetPresented = false
    @StateObject var movieDataStore = MovieDataStore()
    @State var moviesMatchingSearch = Movies()
    @StateObject var controller: MovieCatalogController = MovieCatalogController()

    var chooseBy = ["Year","Genre","Directors","Actors"]
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
                                moviesMatchingSearch = controller.searchForMovie(searchQuery: searchQuery.trimmingCharacters(in: .whitespacesAndNewlines))
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
                        
                        HStack {
                            Text("All Movies")
                                .font(.callout)
                                .frame(alignment: .leading)
                            Spacer()
                            NavigationLink(destination: AllMoviesScreen(movies: controller.movies, sortBy: .byYear, controller: controller)) {
                                Image(systemName: "greaterthan")
                            }.navigationTitle("All Movies")
                        } 
                        .padding()

                    } else {
                        ForEach(moviesMatchingSearch, id: \.imdbID) { each in
                            NavigationLink(destination: MovieDetailView(movie: each)) {
                                MovieCardView(movieModel: MovieModel.convertToMovieCardMode(model: each), imageUrl: each.poster)
                            }
                        }
                    }
                }
                Spacer()
            }
            .padding()
            .overlay(content: {
                if isLoading {
                    ProgressView("Loading")
                } else {
                    EmptyView()
                }
            })
            .navigationTitle("Movie Catalog")
            .task {
                do {
                    try await movieDataStore.saveMoviews()
                } catch {
                    fatalError("Failed to load movies")
                }
                do {
                    try await movieDataStore.loadMovies()
                    controller.movies = movieDataStore.movies
                    
                    isLoading = false
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
