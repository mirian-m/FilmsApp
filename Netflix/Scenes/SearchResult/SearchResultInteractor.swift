//
//  SearchResultInteractor.swift
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

protocol SearchResultBusinessLogic {
    func getSearchResult(request: SearchResult.GetSearchResult.Request)
    func didTapMovie(requset: SearchResult.GetSelectedMovie.Request)

}

protocol SearchResultDataStore {
    var selectedMovieDetails: MovieDetails { get set }
    var searchedMovies: Movies { get set }
}

final class SearchResultInteractor: SearchResultBusinessLogic, SearchResultDataStore {
    var searchedMovies = Movies(details: [])
    var selectedMovieDetails: MovieDetails = MovieDetails()
    var presenter: SearchResultPresentationLogic?
    var worker: SearchResultWorker?
    
    // MARK: Do something
    
    func getSearchResult(request: SearchResult.GetSearchResult.Request) {
        let response = SearchResult.GetSearchResult.Response(searchedMovies: searchedMovies)
        presenter?.presentSearchResult(response: response)
    }
    
    func didTapMovie(requset: SearchResult.GetSelectedMovie.Request) {
        selectedMovieDetails = searchedMovies.details.filter { $0.id! == requset.selectedMovieId }[0]
        presenter?.presentSelectedMovie(response: SearchResult.GetSelectedMovie.Response())

    }
}
