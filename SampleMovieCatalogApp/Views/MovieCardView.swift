//
//  MovieCardView.swift
//  SampleMovieCatalogApp
//
//  Created by Prateek Kovalli on 29/10/24.
//

import SwiftUI

struct MovieCardView: View {
    var movieModel: MovieCardModel
    var imageUrl: String
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: imageUrl)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    
            } placeholder: {
                Image(systemName: "photo.fill").frame(width: 100, height: 150)
            }
            .frame(width: 100, height: 150)
            .padding()
            Spacer()
            VStack(alignment: .leading) {
                Text(movieModel.movieName).font(.headline)
                Spacer()
                LabeledContent("Languages:") {
                    Text(movieModel.language)
                    Spacer()
                }
                .font(.caption)
                LabeledContent("Year:") {
                    Text(movieModel.year)
                    Spacer()
                }
                .font(.caption)
                Spacer()
            }
            .padding()
        }
        .padding()
        .border(Color.black)
    }
}

#Preview {
    MovieCardView(movieModel: MovieModel.convertToMovieCardMode(model: .example), imageUrl: "https://m.media-amazon.com/images/M/MV5BMTUxMjE0NTA5Ml5BMl5BanBnXkFtZTgwNjY0MzM1NjE@._V1_SX300.jpg")
}
