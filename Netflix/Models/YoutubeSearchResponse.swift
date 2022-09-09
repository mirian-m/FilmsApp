
import Foundation

struct YoutubeSearchResponse: Codable {
    struct VideoElements: Codable {
        let id : VideoId
    }
    struct VideoId: Codable {
        let kind: String
        let videoId: String
    }

    let items : [VideoElements]
    
}

