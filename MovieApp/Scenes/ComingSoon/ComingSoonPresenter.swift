//
//  ComingSoonPresenter.swift
//  Netflix
//
//  Created by Admin on 9/2/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ComingSoonPresentationLogic {
    func presentUpcomingMovies(response: ComingSoon.GetUpcomingMovies.Response)
    func presentSelectedMovie(response: ComingSoon.GetSelectedMovie.Response)
}

final class ComingSoonPresenter {
    weak var viewController: ComingSoonDisplayLogic?
}

extension ComingSoonPresenter: ComingSoonPresentationLogic {
    
    //  MARK:- ComingSoonPresentationLogic Methods
    func presentUpcomingMovies(response: ComingSoon.GetUpcomingMovies.Response) {
        guard response.error == nil else {
            viewController?.displayAlert(viewModel: ComingSoon.GetError.ViewModel(errorModel: ErrorViewModel(title: AlerTitle.Error.error, message: response.error!.rawValue)))
            return
        }
        viewController?.displayUpcomingMovies(viewModel: ComingSoon.GetUpcomingMovies.ViewModel(movie: response.movies?.details.convert()))
    }
    
    func presentSelectedMovie(response: ComingSoon.GetSelectedMovie.Response) {
        viewController?.displaySelectedMovie(viewModel: ComingSoon.GetSelectedMovie.ViewModel())
    }
}