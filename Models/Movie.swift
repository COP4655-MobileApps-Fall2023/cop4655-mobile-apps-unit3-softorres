//
//  Movie.swift
//  unit3-flixster-app
//
//  Created by Sofia Torres on 9/18/23.
//

import Foundation
import Foundation

// TODO: Pt 1 - Create a Track model struct
struct Movie: Decodable{
    let original_title: String
    let poster_path: URL  //change to string to append
    let overview: String

    // Detail properties
    let backdrop_path: URL
    let popularity: Double
    let vote_average: Double
    let vote_count: Int
}

struct MovieResponse: Decodable{
    let results: [Movie]
    
}


