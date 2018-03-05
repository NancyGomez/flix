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
    var backdropUrl: URL?
    var releaseDate: String
    
    let baseURL = "https://image.tmdb.org/t/p/w500"
    
    init() {
        title = ""
        overview = ""
//        default red image
        posterUrl = URL(string: "http://www.solidbackgrounds.com/images/1920x1080/1920x1080-red-solid-color-background.jpg")!
        backdropUrl = URL(string: "http://www.solidbackgrounds.com/images/1920x1080/1920x1080-red-solid-color-background.jpg")!
        releaseDate = ""
    }
    
    init(dictionary: [String: Any]) {
        title = dictionary["title"] as? String ?? "No title"
        overview = dictionary["overview"] as? String ?? "No overview"
        let posterStr = dictionary["poster_path"] as? String ?? ""
        posterUrl = URL(string: baseURL + posterStr)!
        let backdropStr = dictionary["backdrop_path"] as? String ?? ""
        backdropUrl = URL(string: baseURL + backdropStr)!
        releaseDate = dictionary["release_date"] as? String ?? "No Release Date"
        
        
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
    
    class func movies(dictionaries: [[String: Any]]) -> [Movie] {
        var movies: [Movie] = []
        for dictionary in dictionaries {
            let movie = Movie(dictionary: dictionary)
            movies.append(movie)
        }
        
        return movies
    }
}
