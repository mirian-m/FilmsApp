import Foundation
import UIKit

public struct API {

    static var dictionariOfAPI =
        [
            "Top": "\(APIConstants.baseURL)/3/movie/top_rated?api_key=\(APIConstants.API_Key)\(APIConstants.endUrl)",
            "Upcoming movies": "\(APIConstants.baseURL)/3/movie/upcoming?api_key=\(APIConstants.API_Key)\(APIConstants.endUrl)",
            "Popular": "\(APIConstants.baseURL)/3/movie/popular?api_key=\(APIConstants.API_Key)\(APIConstants.endUrl)",
            "Trending tv": "\(APIConstants.baseURL)/3/movie/top_rated?api_key=\(APIConstants.API_Key)\(APIConstants.endUrl)",
            "Trending movies": "\(APIConstants.baseURL)/3/trending/movie/day?api_key=\(APIConstants.API_Key)"
        ]
}

public enum APICollerError: String, Error {
    case faldeToGetData = "Falde To get data"
}


class APIColler {
    
    static var shared = APIColler()
    
    func fetchMovieFromAPI (url: String, completion: @escaping (Result<Movies, APICollerError>) -> Void) {
        guard let url = URL(string: url) else { return }
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
    
    func fetchTvShowFromAPI (url: String, completion: @escaping (Result<Movies, APICollerError>)-> Void) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: URLRequest(url: url)) { (data, _, error) in
            guard let data = data, error == nil else { return }
            do {
                let tvShow = try JSONDecoder().decode(Movies.self, from: data)
                completion(.success(tvShow))
            } catch {
                completion(.failure(.faldeToGetData))
            }
        }.resume()
    }
    
    func search(with query: String, completion: @escaping (Result<Movies,APICollerError>) -> Void) {
        
        // Make String Encoding to use Creation Of search Url
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        
        // Create Url with given query
        let urlString = "\(APIConstants.baseURL)/3/search/movie?api_key=\(APIConstants.API_Key)&query=\(query)"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            guard let data = data, error == nil else { return }
            
            do {
                let movie = try JSONDecoder().decode(Movies.self, from: data)
                completion(.success(movie))
            } catch {
                completion(.failure(.faldeToGetData))
            }
            
        }.resume()
    }
    
    func getMovie(with query: String, completion: @escaping (Result<YoutubeSearchResponse, APICollerError>) -> Void) {
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        
        let urlString = "\(APIConstants.youtubeBaseUrl)q=\(query)&key=\(APIConstants.youtubeAPI_KEY)"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data, error == nil else { return }
            
            do {
                let yotubeVideo = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                completion (.success(yotubeVideo))
            } catch {
                completion (.failure(APICollerError.faldeToGetData))
            }
            
        }.resume()
    }
    
    func getImageFromWeb(by url: String,  callback: @escaping ((UIImage?, String)) -> Void) {
        
        guard let ApiUrl = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: ApiUrl) { (data, _, error) in
            guard let data = data, error == nil else { return }
            
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                callback((image, url))
            }
            
        }.resume()
    }
}
