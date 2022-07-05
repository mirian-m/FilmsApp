import Foundation
import UIKit

struct Tv: Codable {
    enum CodingKeys: String, CodingKey {
        case details = "results"
    }
    var details : [TvDetails]
}

struct TvDetails: Codable {
    var id: Int
    var original_language: String?
    var original_name: String?
    var overview: String?
    var popularity: Double?
    var poster_path: String?
    var release_date: String?
    var name: String?
    var vote_average: Double
    var vote_count: Int?
    
}

