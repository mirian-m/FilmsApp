//
//  SearchResultRouter.swift
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

@objc protocol SearchResultRoutingLogic {
    func routeToTrailerVC(segue: UIStoryboardSegue?)
}

protocol SearchResultDataPassing {
    var dataStore: SearchResultDataStore? { get }
}

class SearchResultRouter: NSObject, SearchResultRoutingLogic, SearchResultDataPassing {
    
    weak var viewController: SearchResultViewController?
    var dataStore: SearchResultDataStore?
    
    //  MARK: Routing
    
    func routeToTrailerVC(segue: UIStoryboardSegue?) {
        let destinationVC = MovieTrailerViewController()
        var destinationDS = destinationVC.router!.dataStore!
        passDataToTrailerVC(source: dataStore!, destination: &destinationDS)
        navigateToTrailerVC(source: viewController!, destination: destinationVC)
    }
    
    //  MARK: Navigation
    
    func navigateToTrailerVC(source: SearchResultViewController, destination: UIViewController) {
        source.show(destination, sender: nil)
    }
    
    //  MARK: Passing data
    
    func passDataToTrailerVC(source: SearchResultDataStore, destination: inout MovieTrailerDataStore) {
        destination.movieDetails = source.selectedMovieDetails
    }
}
