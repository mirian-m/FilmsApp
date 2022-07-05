import Foundation
import UIKit

struct Movies: Codable {
    enum CodingKeys: String, CodingKey {
        case details = "results"
    }
    var details: [Details]
}

struct Details: Codable {
    enum CodingKeys: String, CodingKey {
        case id, original_language, overview, popularity, poster_path, release_date, vote_average, vote_count
        case original_name = "original_title"
        case name = "title"
    }
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
