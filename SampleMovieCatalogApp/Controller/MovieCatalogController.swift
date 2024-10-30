//
//  MovieCatalogController.swift
//  SampleMovieCatalogApp
//
//  Created by Prateek Kovalli on 29/10/24.
//

import Foundation
import SwiftUI

@MainActor
class MovieCatalogController: ObservableObject {
    var movies: Movies = []
    private var years = [String]()
    private var actors = [String]()
    private var genres = [String]()
    private var directors = [String]()
    private func getGenres() -> [String] {
        if genres.isEmpty {
            var set = Set<String>()
            movies.forEach { model in
                let values =  splitTheMultiValuesByComma(value: model.genre)
                set = set.union(values)
            }
            genres = Array(set)
        }
        return genres
    }

    private func splitTheMultiValuesByComma(value: String) -> [String] {
        value.components(separatedBy: ",")
    }

    private func getDirectors() -> [String] {
        if directors.isEmpty {
            var set = Set<String>()
            movies.forEach { model in
                let values =  splitTheMultiValuesByComma(value: model.director)
                set = set.union(values)
            }
            directors = Array(set)
        }
        return directors
    }

    private func getActors() -> [String] {
        if actors.isEmpty {
            var set = Set<String>()
            movies.forEach { model in
                let values =  splitTheMultiValuesByComma(value: model.actors)
                set = set.union(values)
            }
            actors = Array(set)
        }
        return actors
    }

    private func getYears() -> [String] {
        if years.isEmpty {
            var set = Set<String>()
            set = set.union(movies.map { model in
                return model.year
            })
            years = Array(set)
        }
        return years
    }

    func getListForSelectedData(selected: SelectionValues ) -> [String] {
        switch selected {
        case .year:
            return getYears()
        case .genre:
            return getGenres()
        case .actors:
            return getActors()
        case .directors:
            return getDirectors()
        }
    }

    func getMoviesBySelectedValue(selectedOption: SelectionValues, value: String) -> Movies {
        switch selectedOption {
        case .year:
            return getMoviesByYears(value: value)
        case .genre:
            return getMoviesByGenere(value: value)
        case .actors:
            return getMoviesByActor(value: value)
        case .directors:
            return getMoviesByDirector(value: value)
        }
    }

    private func getMoviesByGenere(value: String) -> [MovieModel] {
        return movies.filter { model in
            model.genre.contains(value)
        }
    }

    private func getMoviesByDirector(value: String) -> [MovieModel] {
        return movies.filter { model in
            model.director.contains(value)
        }
    }

    private func getMoviesByActor(value: String) -> [MovieModel] {
        return movies.filter { model in
            model.actors.contains(value)
        }
    }

    private func getMoviesByYears(value: String) -> [MovieModel] {
        return movies.filter { model in
            model.year.contains(value)
        }
    }

    private func transFormMovieModelToMovieCardModel(movieModel: MovieModel) -> MovieCardModel {
        return MovieCardModel(movieName: movieModel.title, language: movieModel.language, year: movieModel.year)
    }

    func searchForMovie(searchQuery: String) -> Movies {
        return movies.filter { model in
            return (model.title.contains(searchQuery)) || model.genre.contains(searchQuery) || model.actors.contains(searchQuery) || model.director.contains(searchQuery)
        }
    }
}
