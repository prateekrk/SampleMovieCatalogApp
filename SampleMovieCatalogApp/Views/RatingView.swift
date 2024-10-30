//
//  RatingView.swift
//  SampleMovieCatalogApp
//
//  Created by Prateek Kovalli on 30/10/24.
//

import SwiftUI

struct RatingView: View {
    let source: String
    let value: String
    var body: some View {
        VStack {
            Text(source + " Ratings")
                .font(.title)
            Text(value)
        }
    }
}

#Preview {
    RatingView(source: "IMDB", value: "8")
}
