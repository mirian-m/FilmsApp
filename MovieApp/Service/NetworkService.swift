//  NetworkService.swift
//  Netflix
//  Created by Admin on 9/10/22.

import Foundation
import UIKit

final class NetworkService {
    static let shared = NetworkService()
    
    var session: URLSession
    
    private init() {
        let urlSessionConfiguration = URLSessionConfiguration.default
        let urlSession = URLSession(configuration: urlSessionConfiguration)
        self.session = urlSession
    }
    
    func getData<T: Decodable>(url: URL, completion: @escaping (Result <T, APICollerError>) -> Void) {
        session.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            guard let response = response as? HTTPURLResponse,
                  let data = data,
                  error == nil,
                  (200...299).contains(response.statusCode)
            else {
                completion(.failure(.faldeToGetData))
                return
            }
            do {
                let object = try JSONDecoder().decode(T.self, from: data)
                completion(.success(object))
            } catch {
                completion(.failure(.faldeToGetData))
            }
        }.resume()
    }
    
    //  MARK:- Fetch Image From url using completion hendler
    func getImageFromWeb(by url: String,  completion: @escaping ((UIImage?, String)) -> Void) {
        
        guard let ApiUrl = URL(string: url) else { return }
        
        session.dataTask(with: ApiUrl) { (data, _, error) in
            guard let data = data, error == nil else { return }
            
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                completion((image, url))
            }
        }.resume()
    }
}
