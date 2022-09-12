//
//  NetworkService.swift
//  Netflix
//
//  Created by Admin on 9/10/22.
//

import Foundation

class NetworkService {
    static let shared = NetworkService()
    
    var session: URLSession
    
    private init() {
        let urlSessionConfiguration = URLSessionConfiguration.default
        let urlSession = URLSession(configuration: urlSessionConfiguration)
        self.session = urlSession
    }
    
    func getData<T: Decodable>(url: URL, comletion: @escaping (Result <T, APICollerError>) -> Void) {
        session.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            guard let response = response as? HTTPURLResponse,
                  let data = data,
                  error == nil,
                  (200...299).contains(response.statusCode)
            else {
                comletion(.failure(.faldeToGetData))
                return
            }
            do {
                let object = try JSONDecoder().decode(T.self, from: data)
                comletion(.success(object))
            } catch {
                comletion(.failure(.faldeToGetData))
            }
        }.resume()
    }
}
