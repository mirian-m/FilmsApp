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
    var genres: [String]
    var imageUrl: String
    var rate: Double
    
    init(with model: MovieDetails) {
        self.id = model.id
        self.title = model.title ?? model.original_title ?? ""
        self.imageUrl = model.poster_path ?? ""
        self.rate = model.vote_average ?? 0.0
        self.genres = model.genres?.map({ $0.name }) as! [String]
    }
}
