//
//  SearchMovieRouter.swift
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

protocol SearchMovieRoutingLogic {
    func routeToDetailsrVC(segue: UIStoryboardSegue?)
    func routeToSearcheResulte(segue: UIStoryboardSegue?)
}

protocol SearchMovieDataPassing {
    var dataStore: SearchMovieDataStore? { get }
}

final class SearchMovieRouter: NSObject, SearchMovieDataPassing {
    
    weak var viewController: SearchMovieViewController?
    var dataStore: SearchMovieDataStore?
}

extension SearchMovieRouter:  SearchMovieRoutingLogic {
    
    // MARK: Routing
    func routeToDetailsrVC(segue: UIStoryboardSegue?) {
        let destinationVC = DetailsViewController()
        destinationVC.modalPresentationStyle = .fullScreen
        guard var destinationDS = destinationVC.router?.dataStore else { return }
        passDataToDetailsVc(source: dataStore!, destination: &destinationDS)
        presentDetailsVc(source: viewController!, destination: destinationVC)
    }
    
    func routeToSearcheResulte(segue: UIStoryboardSegue?) {
        guard let destinationVC = viewController?.searchController.searchResultsController as? SearchResultViewController else { return }
        guard var destinationDS = destinationVC.router?.dataStore else { return }
        passSearchedData(source: dataStore!, destination: &destinationDS)
        destinationVC.searchResultIsUpdated = true
    }
    
    // MARK: Passing data
    private func passSearchedData(source: SearchMovieDataStore, destination: inout SearchResultDataStore) {
        destination.searchedMovies = source.searchedMovies
    }
    
    private func passDataToDetailsVc(source: SearchMovieDataStore, destination: inout DetailsDataStore) {
        destination.movieId = source.selectedMovieId
    }
    
    // MARK: Navigation
    private func presentDetailsVc(source: SearchMovieViewController, destination: UIViewController) {
        source.present(destination, animated: true, completion: nil)
    }
}
