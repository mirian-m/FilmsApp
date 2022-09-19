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
    func removeMovieFromWatchedList(request: WatchedList.RemoveSelectedMovie.Request)
}

protocol WatchedListDataStore {
    var selectedMovieId: Int { get set }
}

class WatchedListInteractor: WatchedListDataStore {
    var selectedMovieId: Int = 0
    var presenter: WatchedListPresentationLogic?
    var worker = APIWoker()
    private var moviesList = [MovieDetails]()
}

extension WatchedListInteractor: WatchedListBusinessLogic {
    func removeMovieFromWatchedList(request: WatchedList.RemoveSelectedMovie.Request) {
        moviesList.removeAll { $0.id ==  request.selectedMovieId }
        guard let urser = Auth.auth().currentUser else { return }
        
        let arrayOfMoviesId = moviesList.map { $0.id }
        UserManger.shared.updateUserData(userId: urser.uid, data: [Constants.API.FireBase.Key.WatchedMovies: arrayOfMoviesId]) { [weak self] (error) in
            self?.presenter?.presentWatchedMovies(response: WatchedList.GetWatchedMovies.Response(error: error, movies: self?.moviesList))

        }
    }
    
    func didTapMovie(requset: WatchedList.GetSelectedMovie.Request) {
        selectedMovieId = requset.selectedMovieId
        presenter?.presentSelectedMovie(response: WatchedList.GetSelectedMovie.Response())
    }
    
    func getWatchedMovies(request: WatchedList.GetWatchedMovies.Request) {
        var counter = 0
       
        
        UserManger.shared.getSigInUserData { data in
            if !data.seenMoviesList.isEmpty {
                data.seenMoviesList.forEach { movieId in
                    self.worker.getMovie(by: movieId, complition: { [weak self] (result: Result<MovieDetails, APICollerError>) in
                        counter += 1
                        switch result {
                        case .success(let details):
                            self?.moviesList.append(details)
                        case .failure(let error):
                            print(error)
                        //  TODO:- Error hendling
                        }
                        if  counter == data.seenMoviesList.count {
                            DispatchQueue.main.async { [weak self] in
                                let response = WatchedList.GetWatchedMovies.Response(error: nil, movies: self?.moviesList)
                                self?.presenter?.presentWatchedMovies(response: response)
                            }
                        }
                    })
                }
            } else {
                self.presenter?.presentWatchedMovies(response: WatchedList.GetWatchedMovies.Response())
            }
        }
    }
}
