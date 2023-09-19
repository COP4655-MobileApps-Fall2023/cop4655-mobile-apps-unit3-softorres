//
//  Poster.swift
//  unit3-flixster-app
//
//  Created by Sofia Torres on 9/19/23.
//

import Foundation

struct PosterSearchResponse: Decodable {
    let results: [Poster]
}

struct Poster: Decodable {
    let poster_path: URL
}
