
import Foundation

struct YoutubeSearchResponse: Decodable {
    struct VideoElements: Decodable {
        let id : VideoId
    }
    struct VideoId: Decodable {
        let kind: String
        let videoId: String
    }

    let items : [VideoElements]
    
}

