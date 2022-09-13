//
//  ComingSoonRouter.swift
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

@objc protocol ComingSoonRoutingLogic {
    func routeToDetailsVc(segue: UIStoryboardSegue?)
}

protocol ComingSoonDataPassing {
    var dataStore: ComingSoonDataStore? { get }
}

final class ComingSoonRouter: NSObject, ComingSoonRoutingLogic, ComingSoonDataPassing {
    weak var viewController: ComingSoonViewController?
    var dataStore: ComingSoonDataStore?
    
    // MARK: Routing
    
    func routeToDetailsVc(segue: UIStoryboardSegue?) {
        let destinationVC = DetailsViewController()
        destinationVC.modalPresentationStyle = .fullScreen
//        destinationVC.modalTransitionStyle = .flipHorizontal
        var destinationDS = destinationVC.router!.dataStore!
        passDataToSomewhere(source: dataStore!, destination: &destinationDS)
        navigateToTrailerVC(source: viewController!, destination: destinationVC)
    }
    
    // MARK: Navigation
    
    func navigateToTrailerVC(source: ComingSoonViewController, destination: UIViewController) {
        source.present(destination, animated: true, completion: nil)
    }
    
    // MARK: Passing data
    func passDataToSomewhere(source: ComingSoonDataStore, destination: inout DetailsDataStore) {
        destination.movieId = source.selectedMovieId
    }
}
