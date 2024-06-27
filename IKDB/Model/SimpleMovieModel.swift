//
//  SimpleMovieModel.swift
//  IKDB
//
//  Created by Siros Taib on 6/27/24.
//

import Foundation

class SimpleMovieModel {
    var id: Int
    var name: String
    var date: String
    var rating: String
    var image: URL?
    var description: String
    
    init(movie: Movie) {
        self.id = movie.id
        self.name = movie.name ?? movie.title ?? ""
        self.date = movie.releaseDate ?? movie.firstAirDate ?? ""
        self.rating = "\(movie.voteAverage)/10"
        self.description = movie.overview
        self.image = makeImageURL(movie.posterPath)
        
    }
    
    private func makeImageURL(_ imageCode: String) -> URL? {
        URL(string: "\(NetworkingConstant.shared.imageServerURL)\(imageCode)")
    }
}
