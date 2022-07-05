import Foundation
import UIKit

struct API {
    static var dictionariOfAPI = ["Top":"\(Constant.baseURL)/3/movie/top_rated?api_key=\(Constant.API_Key)\(Constant.endUrl)",
                                  "Upcoming movies":"\(Constant.baseURL)/3/movie/upcoming?api_key=\(Constant.API_Key)\(Constant.endUrl)", "Popular":"\(Constant.baseURL)/3/movie/popular?api_key=\(Constant.API_Key)\(Constant.endUrl)",
                                  "Trending tv":"\(Constant.baseURL)/3/trending/Tv/day?api_key=\(Constant.API_Key)",
                                  "Trending movies":"\(Constant.baseURL)/3/trending/movie/day?api_key=\(Constant.API_Key)"]
}
enum APICollerError: Error {
    case faldeToGetData
}

struct Constant {
    static let API_Key = "793b50b3b4c6ef37ce18bda27b1cbf67"
    static let baseURL = "https://api.themoviedb.org"
    static let endUrl = "&language=en-US&page=1"
    static let PosterBaseURL = "https://image.tmdb.org/t/p/w500/"
    static let YoutubeAPI_KEY = "AIzaSyCFAeVXHQbpbirLUloOmQwuUJBkavE-2rQ"
    static let YoutubeBaseUrl = "https://youtube.googleapis.com/youtube/v3/search?"
}

class APIColler {
    static var shared = APIColler()
    func fetchMovieFromAPI (url: String, completion: @escaping (Result <Movies, APICollerError>) -> Void) {
        guard let url = URL(string: url) else{return}
        URLSession.shared.dataTask(with: URLRequest(url: url)) { (data, _, error) in
            guard let data = data, error == nil else {return}
            do {
                let movie = try JSONDecoder().decode(Movies.self, from: data)
                completion(.success(movie))
            } catch {
                completion(.failure(.faldeToGetData))
            }
        }.resume()
    }
    
    func fetchTvShowFromAPI (url: String, completion: @escaping (Result<Tv,APICollerError>)-> Void) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: URLRequest(url: url)) { (data, _, error) in
            guard let data = data, error == nil else { return }
            do {
                let tvShow = try JSONDecoder().decode(Tv.self, from: data)
                completion(.success(tvShow))
            } catch {
                completion(.failure(.faldeToGetData))
            }
        }.resume()
    }
    
    func search(with query: String, completion: @escaping (Result<Movies,APICollerError>)->Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else{return}
        let urlString = "\(Constant.baseURL)/3/search/movie?api_key=\(Constant.API_Key)&query=\(query)"
        guard let url = URL(string: urlString) else{return}
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data, error == nil else{return}
            do {
                let movie = try JSONDecoder().decode(Movies.self, from: data)
                print(movie.details)
                completion(.success(movie))
            } catch {
                completion(.failure(.faldeToGetData))
            }
        }.resume()
    }
    
    func getMovie (with query: String, completion: @escaping (Result<YoutubeSearchResponse, APICollerError>)->Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        let urlString = "\(Constant.YoutubeBaseUrl)q=\(query)&key=\(Constant.YoutubeAPI_KEY)"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data, error == nil else { return }
            do{
                let yotubeVideo = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                completion (.success(yotubeVideo))
            }catch{
                completion (.failure(APICollerError.faldeToGetData))
            }
        }.resume()
    }
}
