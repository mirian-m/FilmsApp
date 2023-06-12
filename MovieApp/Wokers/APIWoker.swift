//
//  MoviesWoker.swift
//  
//
//  Created by Admin on 8/22/22.
//

import UIKit

final class APIWoker {
    
    func fetchMovieDataBy<T: Decodable>(url: String? = nil, query: String? = nil, completion: @escaping (Result<T, APICollerError>) -> Void) {
        var urlString = url ?? ""
        if let query = query {
            urlString  = ApiHelper.shared.searchMoviesUrlStr + "&query=\(query)"
        }
        guard let url = URL(string: urlString) else { return }
        NetworkService.shared.getData(url: url) { (result: Result<T, APICollerError>) in
            completion(result)
        }
    }
    
    func getMovie<T: Decodable>(by id: Int, complition: @escaping (Result<T, APICollerError>) -> Void) {
        let url = "https://api.themoviedb.org/3/movie/\(id)?api_key=\(Constants.API.Movies.Main.API_Key)"
        fetchMovieDataBy(url: url) { (result) in
            complition(result)
        }
    }
    
    func getTrailer<T: Decodable>(with query: String, completion: @escaping (Result<T, APICollerError>) -> Void) {
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        
        let urlString = "\(Constants.API.Movies.Helper.YoutubeBaseUrl)q=\(query)&key=\(Constants.API.Movies.Helper.YoutubeAPI_KEY)"
        
        guard let url = URL(string: urlString) else { return }
        
        NetworkService.shared.getData(url: url) { (result: Result<T, APICollerError>) in
            completion(result)
        }
        
    }
}
