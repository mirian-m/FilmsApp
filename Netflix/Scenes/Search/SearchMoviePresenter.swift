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
    func presentSelectedMovie(response: SearchMovie.MovieDetail.Response)
}

class SearchMoviePresenter: SearchMoviePresentationLogic {
    
    weak var viewController: SearchMovieDisplayLogic?
    
    // MARK: Do something
    
    func presenMovies(response: SearchMovie.GetMovies.Response) {
        
        //    TODO: - Do error hendiling
        let viewModel = SearchMovie.GetMovies.ViewModel(movie: convert(model: response.movies!))
        viewController?.displayMovies(viewModel: viewModel)
    }
    
    func convert(model: Movies) -> [MovieViewModel] {
        var movieViewModel = [MovieViewModel]()
        
        model.details.forEach { movieDetails in
            let movieModel = MovieViewModel(
                title: movieDetails.original_title ?? movieDetails.title ?? "unknown Film",
                posterUrl: movieDetails.poster_path ?? "",
                id: movieDetails.id ?? -1)
            
            movieViewModel.append(movieModel)
        }
        return movieViewModel
    }
    
    func presentSelectedMovie(response: SearchMovie.MovieDetail.Response) {
        viewController?.displaySelectedMovie(vieModel: SearchMovie.MovieDetail.ViewModel())
    }
}
