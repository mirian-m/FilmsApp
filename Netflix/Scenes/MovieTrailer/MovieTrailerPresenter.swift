//
//  MovieTrailerPresenter.swift
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

protocol MovieTrailerPresentationLogic {
  func presentMovieTrailer(response: MovieTrailer.GetTrailer.Response)
}

class MovieTrailerPresenter: MovieTrailerPresentationLogic {
  weak var viewController: MovieTrailerDisplayLogic?
  
  // MARK: Do something
  
  func presentMovieTrailer(response: MovieTrailer.GetTrailer.Response) {
    let trailerViewModel = TrailerViewModel(movieTitle: response.title, overview: response.overView, youtubeId: response.youtubeId!)
    let viewModel = MovieTrailer.GetTrailer.ViewModel(trailer: trailerViewModel)
    viewController?.displayMovieTrailer(viewModel: viewModel)
  }
}
