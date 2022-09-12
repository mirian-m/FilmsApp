//  Constant.swift
//  Netflix
//
//  Created by Admin on 8/17/22.

import Foundation
import UIKit

enum APIConstants {
    static let API_Key = "793b50b3b4c6ef37ce18bda27b1cbf67"
    static let baseURL = "https://api.themoviedb.org"
    static let endUrl = "&language=en-US&page=1"
    static let posterBaseURL = "https://image.tmdb.org/t/p/w500/"
    static let youtubeAPI_KEY = "AIzaSyCFAeVXHQbpbirLUloOmQwuUJBkavE-2rQ"
    static let youtubeBaseUrl = "https://youtube.googleapis.com/youtube/v3/search?"
    static let firebaseDataBaseReferencUrl = "https://netflixclone-343110-default-rtdb.firebaseio.com/"
}

enum UrlConstant {
    static let top = "\(APIConstants.baseURL)/3/movie/top_rated?api_key=\(APIConstants.API_Key)\(APIConstants.endUrl)"
    static let upcomingMovies = "\(APIConstants.baseURL)/3/movie/upcoming?api_key=\(APIConstants.API_Key)\(APIConstants.endUrl)"
    static let popular = "\(APIConstants.baseURL)/3/movie/popular?api_key=\(APIConstants.API_Key)\(APIConstants.endUrl)"
    static let trendingTv = "\(APIConstants.baseURL)/3/movie/top_rated?api_key=\(APIConstants.API_Key)\(APIConstants.endUrl)"
    static let trendingMovies = "\(APIConstants.baseURL)/3/trending/movie/day?api_key=\(APIConstants.API_Key)"
}
