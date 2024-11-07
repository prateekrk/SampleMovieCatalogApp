//
//  SortOptions.swift
//  SampleMovieCatalogApp
//
//  Created by Prateek Kovalli on 07/11/24.
//

import Foundation
enum SortOptions: String, CaseIterable {
    case byYear  = "Year"
    case aToZMovieNames = "Name (A->Z)"
    case zToAMovieNames = "Name (Z->A)"
}
