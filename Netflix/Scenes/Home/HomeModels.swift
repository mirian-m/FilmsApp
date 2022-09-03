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
    struct Movies: Codable {
        enum CodingKeys: String, CodingKey {
            case details = "results"
        }
        var details: [Details]
        
        struct Details: Codable {
            var id: Int
            var original_language: String?
            var original_title: String?
            var overview: String?
            var popularity: Double?
            var poster_path: String?
            var release_date: String?
            var title: String?
            var vote_average: Double?
            var vote_count: Int?
        }
    }
    // MARK: Use cases
    
    enum MovieInfo {
        struct Request {
            let url: String
        }
        struct Response {
            var result: Result<Movies, APICollerError>
        }
        struct ViewModel {
            var error: String?
            var moviesDetails: [Movies.Details]?
        }
    }
}
