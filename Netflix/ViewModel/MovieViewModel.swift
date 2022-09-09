//
//  WatchedListViewModel.swift
//  Netflix
//
//  Created by Admin on 9/7/22.
//

import Foundation
import UIKit

struct MovieViewModel {
    var id: Int
    var title: String
    var genres: [Genres]
    var imageUrl: String
    var rate: Double
    var overview: String
    var releaseDate: String
    var runTime: Int
    
    init(id: Int, title: String, genres: [Genres], imageUrl: String, rate: Double, overview: String, releaseDate: String, runTime: Int) {
        self.id = id
        self.title = title
        self.imageUrl = imageUrl
        self.rate = rate
        self.genres = genres
        self.overview = overview
        self.releaseDate = releaseDate
        self.runTime = runTime
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
            runTime: model.runtime ?? 0
        )
    }
    init() {
        self.init(
            id: 0,
            title: "",
            genres: [],
            imageUrl: "",
            rate: 0.0,
            overview: "",
            releaseDate: "",
            runTime: 0
        )
    }
}
