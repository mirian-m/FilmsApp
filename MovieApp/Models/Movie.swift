import Foundation
import UIKit

struct Movies: Decodable {
    private enum CodingKeys: String, CodingKey {
        case details = "results"
    }
    var details: [MovieDetails]
}

struct MovieDetails: Decodable {
    private enum CodingKeys: String, CodingKey {
        case genres, id, overview, popularity, runtime, title
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    var genres: [Genres]?
    var id: Int?
    var originalLanguage: String?
    var originalTitle: String?
    var overview: String?
    var popularity: Double?
    var posterPath: String?
    var releaseDate: String?
    var runtime: Int?
    var title: String?
    var voteAverage: Double?
    var voteCount: Int?
}

struct Genres: Decodable, Equatable, Hashable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
    var id: Int?
    var name: String?
}

extension MovieDetails: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}

//  MARK:- convert array of type MovieDetails to array of MovieViewModel type
extension Array where Element == MovieDetails {
    func convert() -> [MovieViewModel] {
        var movieViewModel = [MovieViewModel]()
        
        self.forEach { movieDetails in
            let movieModel = MovieViewModel(with: movieDetails)
            movieViewModel.append(movieModel)
        }
        return movieViewModel
    }
}
