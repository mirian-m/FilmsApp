//
//  DetailsPresenter.swift
//  Netflix
//
//  Created by Admin on 9/8/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol DetailsPresentationLogic {
  func presentMovieDetails(response: Details.GetMovie.Response)
}

final class DetailsPresenter: DetailsPresentationLogic {
  weak var viewController: DetailsDisplayLogic?
  
  // MARK: Do something
  
  func presentMovieDetails(response: Details.GetMovie.Response) {
    guard let movie = response.movie, response.error == nil else {
        viewController?.displayAlert(viewModel: Details.GetError.ViewModel(errorModel: ErrorViewModel(title: AlerTitle.Error.error, message: response.error!.rawValue)))
        return
    }
    let viewModel = Details.GetMovie.ViewModel(movieViewModel: MovieViewModel(with: movie))
    viewController?.displayMovieDetails(viewModel: viewModel)
  }
}
