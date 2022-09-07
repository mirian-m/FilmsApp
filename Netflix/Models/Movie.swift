import Foundation
import UIKit

struct Movies: Decodable {
    enum CodingKeys: String, CodingKey {
        case details = "results"
    }
    var details: [MovieDetails]
}

struct MovieDetails: Decodable {
    var genres: [Genres]?
    var id: Int!
    var original_language: String?
    var original_title: String?
    var overview: String?
    var popularity: Double?
    var poster_path: String?
    var release_date: String?
    var runtime: Int?
    var title: String?
    var vote_average: Double?
    var vote_count: Int?
}

struct Genres: Decodable {
    var name: String?
}



//    var id: String
//    var rank: String
//    var name: String
//    var original_name: String
//    var release_date: String
//    var poster_path: String?
//    var crew: String
//    var imDbRating: String
//    var imDbRatingCount: String
//    var overview: String = ""
//
//    private enum CodingKeys: String, CodingKey {
//         case id
//         case rank
//         case name = "title"
//         case original_name = "fullTitle"
//         case release_date = "year"
//         case poster_path = "image"
//         case crew
//         case imDbRating
//         case imDbRatingCount
//     }

//    enum CodingKeys: String, CodingKey {
//        case poster_path, id, overview, release_date
//        case original_name = "original_title"
//        case name = "title"
//    }
