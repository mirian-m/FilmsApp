import Foundation

struct MovieViewModel {
    var id: Int
    var title: String
    var imageUrl: String
    
    init(title: String, posterUrl: String, id: Int) {
        self.id = id
        self.title = title
        self.imageUrl = posterUrl
    }
    
    init(with model: MovieDetails) {
        self.id = model.id
        self.title = model.title ?? model.original_title ?? ""
        self.imageUrl = model.poster_path ?? ""
    }
}

