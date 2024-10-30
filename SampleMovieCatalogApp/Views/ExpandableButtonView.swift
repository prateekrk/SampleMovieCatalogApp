//
//  ExpandableButtonView.swift
//  SampleMovieCatalogApp
//
//  Created by Prateek Kovalli on 29/10/24.
//

import SwiftUI

struct ExpandableButtonView: View {
    @StateObject var movieViewModel: MovieCatalogController
    let text: String
    @State var movies: [MovieModel] = []
    @State var values: [String] = []
    @State var isExapanded = false
    var body: some View {
            VStack(alignment: .leading) {
                HStack {
                    Text(text)
                        .font(.callout)
                        .frame(alignment: .leading)
                    Spacer()
                    Button {
                        withAnimation {
                            isExapanded = !isExapanded
                            if text == "All Movies" {
                                popuplateMovies()
                            } else {
                                popuplateValues()
                            }
                        }
                    } label: {
                        if isExapanded {
                            Image(systemName: "greaterthan").rotationEffect(Angle(degrees: 90))
                            
                        } else {
                            Image(systemName: "greaterthan")
                        }
                    }
                }
                .padding()
                if isExapanded {
                    if text == "All Movies" {
                        ForEach(movies, id: \.imdbID) { each in
                            NavigationLink(destination: MovieDetailView(movie: each)) {
                                MovieCardView(movieModel: MovieModel.convertToMovieCardMode(model: each), imageUrl: each.poster)
                            }
                        }
                    } else {
                            ForEach(values, id: \.self) { each in
                                NavigationLink( destination: ListOfMoviesView(viewModel: movieViewModel, selectedOption: SelectionValues(rawValue: text) ?? .year, selectedValue: each)) {
                                    ValueCell(value: each)
                                        .border(Color.black)
                                        .frame(maxWidth: .infinity)
                                }
                            }
                    }
                } else {
                    EmptyView()
                }
        }
    }

    func popuplateValues() {
        values = movieViewModel.getListForSelectedData(selected: SelectionValues(rawValue: text) ?? .year)
    }

    func popuplateMovies() {
        movies = movieViewModel.movies
    }
}

#Preview {
    ExpandableButtonView(movieViewModel: MovieCatalogController(), text: "Year", values: ["1997"])
        .frame(width: 300, height: 300)
}
