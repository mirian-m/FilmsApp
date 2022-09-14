//
//  HomeModels.swift
//  Netflix
//
//  Created by Admin on 8/22/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum Home {
    // MARK: Use cases
    
    enum MovieInfo {
        struct Request {
            var section: Int
        }
        struct Response {
            var error: APICollerError?
            var movies: Movies?
        }
        struct ViewModel {
            var error: String?
            var moviesViewModel: [MovieViewModel]
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

