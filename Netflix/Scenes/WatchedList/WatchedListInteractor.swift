//
//  WatchedListInteractor.swift
//  Netflix
//
//  Created by Admin on 9/7/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import FirebaseAuth

protocol WatchedListBusinessLogic {
    func getWatchedMovies(request: WatchedList.GetWatchedMovies.Request)
    func didTapMovie(requset: WatchedList.GetSelectedMovie.Request)
}

protocol WatchedListDataStore {
    var selectedMovieDetails: MovieDetails { get set }
}

class WatchedListInteractor: WatchedListDataStore {
    var selectedMovieDetails: MovieDetails = MovieDetails()
    var presenter: WatchedListPresentationLogic?
    var worker: WatchedListWorke?
    private var movieDetail = [MovieDetails]()
    
    // MARK: Do something
    
}

extension WatchedListInteractor: WatchedListBusinessLogic {
    func didTapMovie(requset: WatchedList.GetSelectedMovie.Request) {
        selectedMovieDetails = movieDetail.filter { $0.id == requset.selectedMovieId }[0]
        presenter?.presentSelectedMovie(response: WatchedList.GetSelectedMovie.Response())
    }
    
    func getWatchedMovies(request: WatchedList.GetWatchedMovies.Request) {
        worker = WatchedListWorke()
        worker?.fetchWatchedMovies(compilition: { favouriteMovies in
            DispatchQueue.main.async { [weak self] in
                self?.movieDetail = favouriteMovies
                let response = WatchedList.GetWatchedMovies.Response(error: nil, movies: favouriteMovies)
                self?.presenter?.presentWatchedMovies(response: response)
            }
        })
    }

}
