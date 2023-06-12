//
//  WatchedListViewModel.swift
//  
//
//  Created by Admin on 9/7/22.
//
import UIKit

struct MovieViewModel: Hashable {
    var id: Int
    var title: String
    var genres: [Genres]
    var imageUrl: String
    var rate: Double
    var overview: String
    var releaseDate: String
    var runTime: Int
    var vote: Int
    
    init(id: Int, title: String, genres: [Genres], imageUrl: String, rate: Double, overview: String, releaseDate: String, runTime: Int, vote: Int) {
        self.id = id
        self.title = title
        self.imageUrl = imageUrl
        self.rate = rate
        self.genres = genres
        self.overview = overview
        self.releaseDate = releaseDate
        self.runTime = runTime
        self.vote = vote
    }
    
    init(with model: MovieDetails) {
        self.init(
            id: model.id ?? -1,
            title: model.title ?? model.originalTitle ?? "",
            genres: model.genres ?? [],
            imageUrl: model.posterPath ?? "",
            rate: model.voteAverage ?? 0.0,
            overview: model.overview ?? "",
            releaseDate: model.releaseDate ?? "",
            runTime: model.runtime ?? 0,
            vote: model.voteCount ?? 0
        )
    }
}
