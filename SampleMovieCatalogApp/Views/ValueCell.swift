//
//  ValueCell.swift
//  SampleMovieCatalogApp
//
//  Created by Prateek Kovalli on 30/10/24.
//

import SwiftUI

struct ValueCell: View {
    let value: String
    var body: some View {
        Text(value)
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.headline)
            .padding()
    }
}

#Preview {
    ValueCell(value: "Comedy")
}
