//
//  HomeInteractor.swift
//  Netflix
//
//  Created by Admin on 8/22/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol HomeBusinessLogic {
    func fetchMovies(request: Home.MovieInfo.Request, complition: @escaping (Bool) -> Void)
    func didTapMovie(requset: Home.GetSelectedMovie.Request)
}

protocol HomeDataStore {
    var selectedMovieDetails: MovieDetails { get set }
}

final class HomeInteractor: HomeBusinessLogic, HomeDataStore {
    var selectedMovieDetails: MovieDetails = MovieDetails()
    var presenter: HomePresentationLogic?
    var worker: APIWoker?
    private var fetchedMovies: Movies = Movies(details: [])
    
    // MARK: Do something
    
    func fetchMovies(request: Home.MovieInfo.Request, complition: @escaping (Bool) -> Void) {
        worker = APIWoker()
        var response = Home.MovieInfo.Response()
        worker?.fetchMoviesDetails(url: request.url, completion: { [weak self] (result: Result<Movies, APICollerError>) in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let movies):
                    response.movies = movies
                    self?.fetchedMovies.details.append(contentsOf: movies.details)
                case .failure(let error):
                    response.error = error
                }
                self?.presenter?.presentMovies(response: response)
                complition(true)
            }
        })
    }
    
    func didTapMovie(requset: Home.GetSelectedMovie.Request) {
        selectedMovieDetails = fetchedMovies.details.filter { $0.id! == requset.selectedMovieId }[0]
        presenter?.presentSelectedMovie(response: Home.GetSelectedMovie.Response())
    }
}
