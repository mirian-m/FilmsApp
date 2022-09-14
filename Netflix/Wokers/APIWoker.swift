//
//  MoviesWoker.swift
//  Netflix
//
//  Created by Admin on 8/22/22.
//

import Foundation
import UIKit

class APIWoker {
    
    func fetchMovieData<T: Decodable>(by url: String?, or query: String?, completion: @escaping (Result<T, APICollerError>) -> Void) {
        var urlString = ""
        if let query = query {
            urlString = "\(Constants.API.Movies.Main.BaseURL)/3/search/movie?api_key=\(Constants.API.Movies.Main.API_Key)&query=\(query)"
        } else {
            guard let url = url else { return }
            urlString = url
        }
        guard let url = URL(string: urlString) else { return }
        NetworkService.shared.getData(url: url) { (result: Result<T, APICollerError>) in
            completion(result)
        }
    }
    
    func getMovie<T: Decodable>(by id: Int, complition: @escaping (Result<T, APICollerError>) -> Void) {
        let url = "https://api.themoviedb.org/3/movie/\(id)?api_key=\(Constants.API.Movies.Main.API_Key)"
        fetchMovieData(by: url, or: nil) { (result) in
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
