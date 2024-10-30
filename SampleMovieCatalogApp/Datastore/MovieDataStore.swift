//
//  MovieDataStore.swift
//  SampleMovieCatalogApp
//
//  Created by Prateek Kovalli on 29/10/24.
//

import Foundation
import SwiftUI
@MainActor
class MovieDataStore: ObservableObject {
    @Published var movies: Movies = [MovieModel]()
    
    private func getFile() throws -> URL {
        return try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathExtension("scrums.data")
    }

    
    func loadMovies() async throws {
        let task = Task<Movies,Error> {
            let fileUrl = try getFile()
            guard let data = try? Data(contentsOf: fileUrl) else {
                return []
            }
            return try JSONDecoder().decode(Movies.self, from: data)
        }
        let movies = try await task.value
        self.movies = movies
    }

    func saveMoviews() async throws {
        let task = Task<Bool, Error> {
            let path = Bundle(for: MovieDataStore.self).path(forResource: "movies", ofType: "json") ?? ""
            let data =  try Data(contentsOf: URL(fileURLWithPath: path))
            let fileUrl = try getFile()
            try data.write(to: fileUrl)
            return true
        }
        _ = try await task.value
    }

}
