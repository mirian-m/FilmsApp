//
//  ComingSoonModels.swift
//  Netflix
//
//  Created by Admin on 9/2/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum ComingSoon {
    
    // MARK: Use cases
    enum GetError {
        struct Request{}
        
        struct Response {}
        
        struct ViewModel {
            var errorModel: ErrorViewModel
            
        }
    }

    enum GetUpcomingMovies {
        
        struct Request{}
        
        struct Response {
            var error: APICollerError?
            var movies: Movies?
        }
        
        struct ViewModel {
            var movie: [MovieViewModel]?
        }
    }
    
    enum GetSelectedMovie {
        struct Request{
            var selectedMovieId: Int
        }
        
        struct Response {}
        
        struct ViewModel {}
    }
}
