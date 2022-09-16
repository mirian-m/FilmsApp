//
//  ApiHelper.swift
//  Netflix
//
//  Created by Admin on 9/14/22.
//

import Foundation
import UIKit

final class ApiHelper {
    
    private enum MovieType {
        static let trendingmovies = (type: "Trending movies", url: "/3/trending/movie/day?api_key=")
        static let top = (type: "Top", url: "/3/movie/top_rated?api_key=")
        static let upcomingMovies = (type: "Upcoming movies", url: "/3/movie/upcoming?api_key=")
        static let popular = (type: "Popular", url: "/3/movie/popular?api_key=")
        static let nowPlaying = (type: "Now playing", url: "/3/movie/now_playing?api_key=")
        static let search = (type: "Search", url: "/3/discover/movie?api_key=")
    }
    
    static let shared = ApiHelper()
    
    private let baseUrl: String
    private let apiKey: String
    private let page: String
    
    private init() {
        self.baseUrl = Constants.API.Movies.Main.BaseURL
        self.apiKey = Constants.API.Movies.Main.API_Key
        self.page = "\(Int.random(in: 1...10))"
    }
    
    func getMovieUrl(by movieType: String) -> String {
        var urlStr = ""
        switch movieType {
        case MovieType.trendingmovies.type:
            urlStr = MovieType.trendingmovies.url
        case MovieType.top.type:
            urlStr = MovieType.top.url
        case MovieType.upcomingMovies.type:
            urlStr = MovieType.upcomingMovies.url
        case MovieType.popular.type:
            urlStr = MovieType.popular.url
        case MovieType.nowPlaying.type:
            urlStr = MovieType.nowPlaying.url
        case MovieType.search.type:
            urlStr = MovieType.search.url
        default:
            break
        }
        return baseUrl + urlStr + apiKey + "&page=" + page
    }
}
