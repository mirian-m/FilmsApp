//
//  SearchMovieInteractor.swift
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

protocol SearchMovieBusinessLogic {
    func getMovies(request: SearchMovie.GetMovies.Request)
    func didTapMovie(requset: SearchMovie.GetSelectedMovie.Request)
    func updateSearchResult(requset: SearchMovie.GetSearchedMovies.Request)
    
}

protocol SearchMovieDataStore {
    var selectedMovieDetails: MovieDetails { get set }
    var searchedMovies: Movies { get set }
}

final class SearchMovieInteractor: SearchMovieBusinessLogic, SearchMovieDataStore {
    var presenter: SearchMoviePresentationLogic?
    var worker: APIWoker? = APIWoker()
    
    var selectedMovieDetails: MovieDetails = MovieDetails()
    var searchedMovies = Movies(details: [])
    
    private var fetchedMovies = Movies(details: [])
    
    
    //  MARK: SearchMovieBusinessLogic Protocol Functions
    
    func getMovies(request: SearchMovie.GetMovies.Request) {
        let url =  "\(APIConstants.baseURL)/3/discover/movie?api_key=\(APIConstants.API_Key)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate"
        
        worker?.fetchMoviesDetails(url: url, completion: { [weak self] (result: Result<Movies, APICollerError>) in
            DispatchQueue.main.async {
                var response = SearchMovie.GetMovies.Response()
                switch result {
                case .success(let movies):
                    self?.fetchedMovies = movies
                    response.movies = movies
                case .failure(let error):
                    response.error = error
                }
                self?.presenter?.presenMovies(response: response)
            }
        })
    }
    
    func didTapMovie(requset: SearchMovie.GetSelectedMovie.Request) {
        selectedMovieDetails = fetchedMovies.details.filter { $0.id! == requset.selectedMovieId }[0]
        presenter?.presentSelectedMovie(response: SearchMovie.GetSelectedMovie.Response())
    }
    
    func updateSearchResult(requset: SearchMovie.GetSearchedMovies.Request) {
        var response = SearchMovie.GetSearchedMovies.Response()
        
        worker?.searchMoviees(with: requset.query, completion: { [weak self] (result: Result<Movies, APICollerError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let searchedMovies):
                    self?.searchedMovies = searchedMovies
                    response.searchedMovies = searchedMovies
                case .failure(let error):
                    response.error = error
                }
                self?.presenter?.presentSearchedMovies(response: response)
            }
        })
    }
}
