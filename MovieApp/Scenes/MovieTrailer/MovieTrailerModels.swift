//
//  MovieTrailerModels.swift
//  Netflix
//
//  Created by Admin on 9/5/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum MovieTrailer {
  // MARK: Use cases
  
    enum GetError {
        struct Request{}
        
        struct Response {}
        
        struct ViewModel {
            var errorModel: ErrorViewModel
        }
    }

  enum GetTrailer {
    struct Request {}
    
    struct Response {
        var error: APICollerError?
        var youtubeId: String?
        var overView: String?
        var title: String?
    }
    
    struct ViewModel {
        var trailer: TrailerViewModel
    }
  }
}
