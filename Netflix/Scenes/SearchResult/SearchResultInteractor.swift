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
    func didTapMovie(requset: SearchResult.MovieDetail.Request)

}

protocol SearchResultDataStore {
    var movieDetails: Details { get set }
    var searchedMovies: Movies { get set }
}

class SearchResultInteractor: SearchResultBusinessLogic, SearchResultDataStore {
    var searchedMovies = Movies(details: [])
    var movieDetails: Details = Details()
    var presenter: SearchResultPresentationLogic?
    var worker: SearchResultWorker?
    //var name: String = ""
    
    // MARK: Do something
    
    func getSearchResult(request: SearchResult.GetSearchResult.Request) {
        let response = SearchResult.GetSearchResult.Response(searchedMoviesDetails: searchedMovies)
        presenter?.presentSearchResult(response: response)
    }
    
    func didTapMovie(requset: SearchResult.MovieDetail.Request) {
        movieDetails = searchedMovies.details.filter { $0.id! == requset.selectedMovieId }[0]
        presenter?.presentSelectedMovie(response: SearchResult.MovieDetail.Response())

    }
}
