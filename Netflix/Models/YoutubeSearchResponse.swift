
import Foundation

struct YoutubeSearchResponse: Codable {
    let items : [VideoElements]
}

struct VideoElements: Codable {
    let id : VideoId
}
struct VideoId: Codable {
    let kind: String
    let videoId: String
}
