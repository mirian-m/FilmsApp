import Foundation

struct MovieViewModel {
    var id: Int!
    var title: String
    var posterUrl: String
    
    init(title: String, posterUrl: String, id: Int) {
        self.id = id
        self.title = title
        self.posterUrl = posterUrl
    }
    init() {
        self.title = ""
        self.posterUrl = ""
    }
}

