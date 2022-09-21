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

final class WatchedListRouter: NSObject {
    weak var viewController: WatchedListViewController?
    var dataStore: WatchedListDataStore?
}

extension WatchedListRouter: WatchedListRoutingLogic, WatchedListDataPassing {
    // MARK: Routing
    
    func routeToTrailerVC(segue: UIStoryboardSegue?) {
        let destinationVC = DetailsViewController()
        destinationVC.modalPresentationStyle = .fullScreen
        var destinationDS = destinationVC.router!.dataStore!
        passDataToDetailsVc(source: dataStore!, destination: &destinationDS)
        presentDetailsVc(source: viewController!, destination: destinationVC)
    }
    
    // MARK: Navigation
    
    private func presentDetailsVc(source: WatchedListViewController, destination: UIViewController) {
        source.present(destination, animated: true, completion: nil)
    }
    
    // MARK: Passing data
    
    private func passDataToDetailsVc(source: WatchedListDataStore, destination: inout DetailsDataStore) {
        destination.movieId = source.selectedMovieId
    }
    
}
