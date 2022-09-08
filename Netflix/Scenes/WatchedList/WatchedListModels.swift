//
//  WatchedListModels.swift
//  Netflix
//
//  Created by Admin on 9/7/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum WatchedList {
    // MARK: Use cases
    
    enum GetWatchedMovies {
        struct Request { }
        
        struct Response {
            var error: APICollerError?
            var movies: [MovieDetails]?
        }
        struct ViewModel {
            var watchedMoviesModel: [MovieViewModel]
        }
    }
    
    enum GetSelectedMovie {
        struct Request{
            var selectedMovieId: Int
        }
        
        struct Response {}
        
        struct ViewModel {}
    }
    
    enum RemoveSelectedMovie {
        struct Request{
            var selectedMovieId: Int
        }
        
        struct Response {}
        
        struct ViewModel { }
    }
}
