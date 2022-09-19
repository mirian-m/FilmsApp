//
//  ComingSoonInteractor.swift
//  Netflix
//
//  Created by Admin on 9/2/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ComingSoonBusinessLogic {
    func getUpcomingMovies(request: ComingSoon.GetUpcomingMovies.Request)
    func didTapMovie(requset: ComingSoon.GetSelectedMovie.Request)
}

protocol ComingSoonDataStore {
    var selectedMovieId: Int { get set }
}

final class ComingSoonInteractor: ComingSoonDataStore {
    var presenter: ComingSoonPresentationLogic?
    var worker = APIWoker()
    private var fetchedMovies = Movies(details: [])
    var selectedMovieId = 0
}

extension ComingSoonInteractor:  ComingSoonBusinessLogic {
    
    //  MARK:- ComingSoonBusinessLogic Methods
    func getUpcomingMovies(request: ComingSoon.GetUpcomingMovies.Request) {
        let url = ApiHelper.shared.upcomingMoviesUrlStr
        worker.fetchMovieData(by: url, completion: { (result: Result<Movies, APICollerError>) in
            DispatchQueue.main.async { [weak self] in
                var response = ComingSoon.GetUpcomingMovies.Response()
                switch result {
                case .success(let upcomingMovies):
                    self?.fetchedMovies = upcomingMovies
                    response.movies = upcomingMovies
                case .failure(let error):
                    response.error = error
                }
                self?.presenter?.presentUpcomingMovies(response: response)
            }
        })
    }
    func didTapMovie(requset: ComingSoon.GetSelectedMovie.Request) {
        selectedMovieId = requset.selectedMovieId
        presenter?.presentSelectedMovie(response: ComingSoon.GetSelectedMovie.Response())
    }
}