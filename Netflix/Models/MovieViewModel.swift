import Foundation

struct MovieViewModel {
    var id: Int!
    var title: String
    var imageUrl: String
    
    init(title: String, posterUrl: String, id: Int) {
        self.id = id
        self.title = title
        self.imageUrl = posterUrl
    }
    init() {
        self.title = ""
        self.imageUrl = ""
    }
}

