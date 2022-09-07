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
    
    //  MARK:- Initializer With model
    init(with model: MovieDetails) {
        self.init(title: model.title ?? model.original_title ?? "", posterUrl: model.poster_path ?? "", id: model.id)
    }
    
}

