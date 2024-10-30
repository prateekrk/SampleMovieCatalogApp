//
//  MovieDetailView.swift
//  SampleMovieCatalogApp
//
//  Created by Prateek Kovalli on 30/10/24.
//

import SwiftUI

struct MovieDetailView: View {
    let movie: MovieModel
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    AsyncImage(url: URL(string: movie.poster)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        Image(systemName: "photo.fill").frame(width: 200, height: 300)
                    }
                    Section(header: Text("Plot")) {
                        Text(movie.plot)
                    }
                    .frame(alignment: .leading)
                    Section(header: Text("Cast And Crew")) {
                        LabeledContent("Cast", value: movie.actors)
                        LabeledContent("Directos", value: movie.director)
                        LabeledContent("Writters", value: movie.writer)
                    }
                    .frame(alignment: .leading)
                    Section(header: Text("Released Data")) {
                        Label(movie.released, systemImage: "calendar")
                    }
                    .frame(alignment: .leading)
                    Section(header: Text("Genre")) {
                        Text(movie.genre)
                    }
                    .frame(alignment: .leading)
                    Section(header: Text("Rating")) {
                        ForEach(movie.ratings, id: \.source) { each in
                            NavigationLink {
                                RatingView(source: each.source, value: each.value)
                            } label: {
                                Label(each.source, systemImage: "star.leadinghalf.filled")
                            }
                            
                        }
                    }
                    .frame(alignment: .leading)
                }
            }
        }.navigationTitle(movie.title)
    }
}

#Preview {
    MovieDetailView(movie: .example)
}
