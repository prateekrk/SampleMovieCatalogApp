//
//  SelectionValues.swift
//  SampleMovieCatalogApp
//
//  Created by Prateek Kovalli on 29/10/24.
//

import Foundation
enum SelectionValues: String, Codable, CaseIterable {
    case year = "Year"
    case genre = "Genre"
    case actors = "Actors"
    case directors = "Directors"
}
