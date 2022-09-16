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
    var selectedMovieId: Int { get set }
    var searchedMovies: Movies { get set }
}

final class SearchResultInteractor: SearchResultDataStore {
    var searchedMovies = Movies(details: [])
    var selectedMovieId: Int = 0
    var presenter: SearchResultPresentationLogic?
    var worker: SearchResultWorker?
    
}

extension SearchResultInteractor: SearchResultBusinessLogic {
    
    //  MARK: SearchResultBusinessLogic Methods
    func getSearchResult(request: SearchResult.GetSearchResult.Request) {
        let response = SearchResult.GetSearchResult.Response(searchedMovies: searchedMovies)
        presenter?.presentSearchResult(response: response)
    }
    
    func didTapMovie(requset: SearchResult.GetSelectedMovie.Request) {
        selectedMovieId = requset.selectedMovieId
        presenter?.presentSelectedMovie(response: SearchResult.GetSelectedMovie.Response())
    }
}
