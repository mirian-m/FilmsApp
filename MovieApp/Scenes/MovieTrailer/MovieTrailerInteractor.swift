//
//  MovieTrailerInteractor.swift
//  
//
//  Created by Admin on 9/5/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol MovieTrailerBusinessLogic {
    func getTrailer(request: MovieTrailer.GetTrailer.Request)
}

protocol MovieTrailerDataStore {
    var movieDetails: MovieDetails { get set }
}

final class MovieTrailerInteractor: MovieTrailerDataStore {
    var presenter: MovieTrailerPresentationLogic?
    var worker: APIWoker?
    var movieDetails: MovieDetails = MovieDetails()
    
}
//  MARK:- Extension MovieTrailerBusinessLogic Methods
extension MovieTrailerInteractor:  MovieTrailerBusinessLogic {
    
    //  MARK: Get Trailer
    func getTrailer(request: MovieTrailer.GetTrailer.Request) {
        worker = APIWoker()
        let overView = movieDetails.overview ?? ""
        let title = movieDetails.title ?? movieDetails.originalTitle ?? ""
        var youtubeId: String = ""
        var errorMessage: APICollerError?
        let query = title + " trailer"
        
        worker?.getTrailer(with: query, completion: { (result: Result<YoutubeSearchResponse, APICollerError>) in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let youtubeResult):
                    youtubeId = youtubeResult.items.first?.id?.videoId ?? ""
                case .failure(let error):
                    errorMessage = error
                }
                let response = MovieTrailer.GetTrailer.Response(error: errorMessage, youtubeId: youtubeId, overView: overView, title: title)
                self?.presenter?.presentMovieTrailer(response: response)
            }
        })
    }
    
}
