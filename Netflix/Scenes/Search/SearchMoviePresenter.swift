//
//  SearchMoviePresenter.swift
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

protocol SearchMoviePresentationLogic {
    func presenMovies(response: SearchMovie.GetMovies.Response)
    func presentSelectedMovie(response: SearchMovie.GetSelectedMovie.Response)
    func presentSearchedMovies(response: SearchMovie.GetSearchedMovies.Response)
}

final class SearchMoviePresenter: SearchMoviePresentationLogic {
    weak var viewController: SearchMovieDisplayLogic?
    
    // MARK: Do something
    func presenMovies(response: SearchMovie.GetMovies.Response) {
        
        //    TODO: - Do error hendiling
        let viewModel = SearchMovie.GetMovies.ViewModel(movie: response.movies?.details.convert() ?? [])
        viewController?.displayMovies(viewModel: viewModel)
    }
    
    func presentSelectedMovie(response: SearchMovie.GetSelectedMovie.Response) {
        viewController?.displaySelectedMovie(vieModel: SearchMovie.GetSelectedMovie.ViewModel())
    }
    
    func presentSearchedMovies(response: SearchMovie.GetSearchedMovies.Response) {
        //    TODO: - Do error hendiling
        let viewModel = SearchMovie.GetSearchedMovies.ViewModel(movieViewModel: (response.searchedMovies?.details.convert()) ?? [])
        viewController?.displaySearchedMovies(viewModel: viewModel)
    }
}
