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
    //    func fetchMovies(request: Home.MovieInfo.Request)
    func fetchMovies(request: Home.MovieInfo.Request, complition: @escaping (Bool) -> Void)
    
}

protocol HomeDataStore {
    //var name: String { get set }
}

class HomeInteractor: HomeBusinessLogic, HomeDataStore {
    var presenter: HomePresentationLogic?
    var worker: APIWoker?
    //var name: String = ""
    
    // MARK: Do something
    
    //    func fetchMovies(request: Home.MovieInfo.Request) {
    func fetchMovies(request: Home.MovieInfo.Request, complition: @escaping (Bool) -> Void) {
        worker = APIWoker()
        //        var response = Home.MovieInfo.Response()
        worker?.fetchMoviesDetails(url: request.url, completion: { [weak self] (result: Result<Home.Movies, APICollerError>) in
            let response = Home.MovieInfo.Response(result: result)
            //            switch result {
            //            case .success(let movies):
            //                response = Home.MovieInfo.Response(error: nil, moviesDetails: movies.details)
            //            case .failure(let error):
            //                response = Home.MovieInfo.Response(error: error, moviesDetails: nil)
            //            }
            self?.presenter?.presentMovies(response: response)
            complition(true)
        })
    }
}
