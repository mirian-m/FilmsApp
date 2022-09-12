//
//  MoviesWoker.swift
//  Netflix
//
//  Created by Admin on 8/22/22.
//

import Foundation
import UIKit

class APIWoker {
    
    func fetchMoviesDetails<T: Decodable>(url: String, completion: @escaping (Result<T, APICollerError>) -> Void) {
        guard let url = URL(string: url) else { return }
        
        NetworkService.shared.getData(url: url) { (result: Result<T, APICollerError>) in
            completion(result)
        }
    }
    func searchMoviees<T: Decodable>(with query: String, completion: @escaping (Result<T, APICollerError>) -> Void) {
        
        // Make String Encoding to use Creation Of search Url
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        
        // Create Url with given query
        let urlString = "\(APIConstants.baseURL)/3/search/movie?api_key=\(APIConstants.API_Key)&query=\(query)"
        
        guard let url = URL(string: urlString) else { return }
        
        NetworkService.shared.getData(url: url) { (result: Result<T, APICollerError>) in
            completion(result)
        }
    }
    
    func getMovie<T: Decodable>(with query: String, completion: @escaping (Result<T, APICollerError>) -> Void) {
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        
        let urlString = "\(APIConstants.youtubeBaseUrl)q=\(query)&key=\(APIConstants.youtubeAPI_KEY)"
        
        guard let url = URL(string: urlString) else { return }
        
        NetworkService.shared.getData(url: url) { (result: Result<T, APICollerError>) in
            completion(result)
        }
        
    }
    
    func fetchImageFromWeb(by url: String,  callback: @escaping ((UIImage?, String)) -> Void) {
        
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
