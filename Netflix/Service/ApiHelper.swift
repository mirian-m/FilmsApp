//
//  ApiHelper.swift
//  Netflix
//
//  Created by Admin on 9/14/22.
//

import Foundation
import UIKit

class ApiHelper {
    
    static let shared = ApiHelper()
    
    func getMovieUrl(by movieType: String) -> URL? {
        return nil
        
    }
    enum MovieType {
        static let trendingmovies = (type: "Trending movies", url: "/3/trending/movie/day?api_key=")
        static let top = (type: "Top", url: "/3/movie/top_rated?api_key=")
        static let upcomingMovies = (type: "Upcoming movies", url: "/3/movie/upcoming?api_key=")
        static let popular = (type: "Popular", url: "/3/movie/popular?api_key=")
        static let nowPlaying = "https://api.themoviedb.org/3/movie/now_playing?api_key=793b50b3b4c6ef37ce18bda27b1cbf67&language=en-US&page=2"
    }
    
}
