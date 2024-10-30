//
//  MovieModel.swift
//  SampleMovieCatalogApp
//
//  Created by Prateek Kovalli on 29/10/24.
//

import Foundation
struct MovieModel: Codable {
    let title, year, rated, released: String
    let runtime, genre, director, writer: String
    let actors, plot, language, country: String
    let awards: String
    let poster: String
    let ratings: [Rating]
    let metascore, imdbRating, imdbVotes, imdbID: String
    let type: TypeEnum
    let dvd: String?
    let boxOffice, production: String?
    let website: String?
    let response: String
    let totalSeasons: String?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case rated = "Rated"
        case released = "Released"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case plot = "Plot"
        case language = "Language"
        case country = "Country"
        case awards = "Awards"
        case poster = "Poster"
        case ratings = "Ratings"
        case metascore = "Metascore"
        case imdbRating, imdbVotes, imdbID
        case type = "Type"
        case dvd = "DVD"
        case boxOffice = "BoxOffice"
        case production = "Production"
        case website = "Website"
        case response = "Response"
        case totalSeasons
    }

    static var example: MovieModel = MovieModel(title: "Meet the Parents", year: "2000", rated: "PG-13", released:"06 Oct 2000", runtime: "108 min", genre: "Comdey, Romance", director: "Jay Roach", writer: "Greg Glienna, Mary Ruth Clarke, Greg Glienna (story), Mary Ruth Clarke (story), Jim Herzfeld (screenplay), John Hamburg (screenplay)", actors: "Robert De Niro, Ben Stiller, Teri Polo, Blythe Danner", plot: "A Jewish male nurse plans to ask his live-in girl friend to marry him. However, he learns that her strict father expects to be asked for his daughter's hand before she can accept. Thus begins the visit from Hell as the two travel to meet Mom and Dad, who turns out to be former CIA with a lie detector in the basement. Coincidentally, a sister also has announced her wedding to a young doctor. Of course everything that can go wrong, does, including the disappearance of Dad's beloved Himalayan cat, Jinxie.", language:  "English, Thai, Spanish, Hebrew, French", country: "USA", awards: "Nominated for 1 Oscar. Another 7 wins & 14 nominations.", poster: "https://m.media-amazon.com/images/M/MV5BMGNlMGZiMmUtZjU0NC00MWU4LWI0YTgtYzdlNGVhZGU4NWZlXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_SX300.jpg", ratings: [Rating(source: "Internet Movie Database", value: "7.0/10")], metascore: "73", imdbRating: "7.0", imdbVotes: "310,464", imdbID:  "tt0212338", type: .movie, dvd: "N/A", boxOffice: "$166,244,045", production: "Nancy Tenenbaum Productions, Universal Pictures, Tribeca Productions, DreamWorks Pictures", website: "N/A", response: "True", totalSeasons: nil)

    static func convertToMovieCardMode(model: MovieModel) -> MovieCardModel {
        return MovieCardModel(movieName: model.title, language: model.language, year: model.year)
    }
}

// MARK: - Rating
struct Rating: Codable {
    let source: String
    let value: String

    enum CodingKeys: String, CodingKey {
        case source = "Source"
        case value = "Value"
    }
}

enum TypeEnum: String, Codable {
    case movie = "movie"
    case series = "series"
}

typealias Movies = [MovieModel]
