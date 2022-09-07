//
//  WatchedListRouter.swift
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

protocol WatchedListRoutingLogic {
    func routeToTrailerVC(segue: UIStoryboardSegue?)
    
}

protocol WatchedListDataPassing {
    var dataStore: WatchedListDataStore? { get }
}

class WatchedListRouter: NSObject {
    weak var viewController: WatchedListViewController?
    var dataStore: WatchedListDataStore?
}

extension WatchedListRouter: WatchedListRoutingLogic, WatchedListDataPassing {
    // MARK: Routing

    func routeToTrailerVC(segue: UIStoryboardSegue?) {
        let destinationVC = MovieTrailerViewController()
        var destinationDS = destinationVC.router!.dataStore!
        passDataToTrailerVC(source: dataStore!, destination: &destinationDS)
        navigateToTrailerVC(source: viewController!, destination: destinationVC)
    }

    // MARK: Navigation
    
    func navigateToTrailerVC(source: WatchedListViewController, destination: UIViewController) {
        source.show(destination, sender: nil)
    }
    
    // MARK: Passing data
    
    func passDataToTrailerVC(source: WatchedListDataStore, destination: inout MovieTrailerDataStore) {
        destination.movieDetails = source.selectedMovieDetails
    }
    
}
