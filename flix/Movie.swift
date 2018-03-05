//
//  Movie.swift
//  flix
//
//  Created by Nancy Gomez on 3/4/18.
//  Copyright © 2018 Nancy Gomez. All rights reserved.
//

import Foundation

class Movie {
    var title: String
    var overview: String
    var posterUrl: URL?
    
    init(dictionary: [String: Any]) {
        title = dictionary["title"] as? String ?? "No title"
        overview = dictionary["overview"] as? String ?? "No overview"
        
        let posterPath = dictionary["poster_path"] as? String
        if let posterPath = posterPath {
            let baseUrlString = "https://image.tmdb.org/t/p/w500"
            let fullPosterPath = baseUrlString + posterPath
            let maybeURL = URL(string: fullPosterPath)
            if maybeURL != nil {
               posterUrl = maybeURL
            }
        }
        
    }
}
