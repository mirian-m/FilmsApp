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
        static let discover = "/3/discover/movie?api_key="
        static let search = "/3/search/movie?api_key="
    }
    static let shared = ApiHelper()
    
    private let baseUrl: String = Constants.API.Movies.Main.BaseURL
    private let apiKey: String = Constants.API.Movies.Main.API_Key
    private let page: String = "&page=\(Int.random(in: 2...8))"

    var upcomingMoviesUrlStr: String {
        return baseUrl + MovieType.upcomingMovies.url + apiKey + page
    }
    var discoverMoviesUrlStr: String {
        return baseUrl + MovieType.discover + apiKey + page
    }
    var searchMoviesUrlStr: String {
        return baseUrl + MovieType.search + apiKey
    }
    
    private init() {}
    
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
        default:
            break
        }
        return baseUrl + urlStr + apiKey + page
    }
}
