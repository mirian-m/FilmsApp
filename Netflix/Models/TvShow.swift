import Foundation
import UIKit

struct Tv: Codable {
    enum CodingKeys: String, CodingKey {
        case details = "items"
    }
    var details: [TvDetails]
    var errorMessage: String?
    
}

struct TvDetails: Codable {
    //    enum CodingKeys: String, CodingKey {
    //        case releaseDate = "year"
    //        case imageUrl = "image"
    //    }
    var id: String
    var rank: String
    var title: String
    var fullTitle: String
    var year: String
    var image: String
    var crew: String
    var imDbRating: String
    var imDbRatingCount: String
    //    var original_language: String?
    //    var original_name: String?
    //    var overview: String?
    //    var popularity: Double?
    //    var poster_path: String?
    //    var release_date: String?
    //    var name: String?
    //    var vote_average: Double
    //    var vote_count: Int?
}

