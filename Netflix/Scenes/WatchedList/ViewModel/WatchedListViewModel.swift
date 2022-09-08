//
//  WatchedListViewModel.swift
//  Netflix
//
//  Created by Admin on 9/7/22.
//

import Foundation
import UIKit

struct WatchedListViewModel {
    var id: Int
    var title: String
    var genres: [Genres]
    var imageUrl: String
    var rate: Double
    
    init(id: Int, title: String, genres: [Genres], imageUrl: String, rate: Double) {
        self.id = id
        self.title = title
        self.imageUrl = imageUrl
        self.rate = rate
        self.genres = genres
    }
    
    init(with model: MovieDetails) {
        self.init(
            id: model.id ?? -1,
            title: model.title ?? model.original_title ?? "",
            genres: model.genres ?? [],
            imageUrl: model.poster_path ?? "",
            rate: model.vote_average ?? 0.0
        )
    }
}
