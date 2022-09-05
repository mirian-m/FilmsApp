//
//  MovieTrailerInteractor.swift
//  Netflix
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
  var movieDetails: Details { get set }
}

class MovieTrailerInteractor: MovieTrailerBusinessLogic, MovieTrailerDataStore {
  var presenter: MovieTrailerPresentationLogic?
  var worker: APIWoker?
  var movieDetails: Details = Details()
  
  // MARK: Do something
  
  func getTrailer(request: MovieTrailer.GetTrailer.Request) {
    
    worker = APIWoker()
    let overView = movieDetails.overview ?? ""
    let title = movieDetails.title ?? movieDetails.original_title ?? ""
    var response = MovieTrailer.GetTrailer.Response(youtubeId: nil, overView: overView, title: title)
    let query = title + " trailer"
    
    worker?.getMovie(with: query, completion: { [weak self] result in
        switch result {
        case .success(let youtubeResult):
            response.youtubeId = youtubeResult.items[0].id
        case .failure(let error):
            print(error.localizedDescription)
        }
        self?.presenter?.presentMovieTrailer(response: response)
    })
  }
}
