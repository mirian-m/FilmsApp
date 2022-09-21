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
    var selectedMovieId: Int { get set }
    var searchedMovies: Movies { get set }
}

final class SearchMovieInteractor: SearchMovieBusinessLogic, SearchMovieDataStore {
    var presenter: SearchMoviePresentationLogic?
    var worker: APIWoker? = APIWoker()
    
    var selectedMovieId: Int = 0
    var searchedMovies = Movies(details: [])
    
    private var fetchedMovies = Movies(details: [])
    
    
    //  MARK: SearchMovieBusinessLogic Protocol Functions
    
    func getMovies(request: SearchMovie.GetMovies.Request) {
        let url = ApiHelper.shared.discoverMoviesUrlStr
        
        worker?.fetchMovieDataBy(url: url, completion: { (result: Result<Movies, APICollerError>) in
            DispatchQueue.main.async { [weak self] in
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
        selectedMovieId = requset.selectedMovieId
        presenter?.presentSelectedMovie(response: SearchMovie.GetSelectedMovie.Response())
    }
    
    //  MARK:- Get Searched movies
    func updateSearchResult(requset: SearchMovie.GetSearchedMovies.Request) {
        guard let query = requset.query,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3
        else { return }
        var response = SearchMovie.GetSearchedMovies.Response()
        worker?.fetchMovieDataBy(query: query, completion: { (result: Result<Movies, APICollerError>) in
            DispatchQueue.main.async { [weak self]  in
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
