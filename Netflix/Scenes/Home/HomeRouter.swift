//
//  HomeRouter.swift
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

@objc protocol HomeRoutingLogic {
    func routeToProfile(segue: UIStoryboardSegue?)
    func routeToWelcomePage(segue: UIStoryboardSegue?)
    func routToTrailerVc(segue: UIStoryboardSegue?)
}

protocol HomeDataPassing {
    var dataStore: HomeDataStore? { get }
}

final class HomeRouter: NSObject, HomeRoutingLogic, HomeDataPassing {
    
    weak var viewController: HomeViewController?
    var dataStore: HomeDataStore?
    
    //  MARK: Routing
    
    func routeToProfile(segue: UIStoryboardSegue?) {
        let destinationVC = ProfileViewController()
        destinationVC.delegate = self.viewController
        present(source: viewController!, destination: destinationVC)
    }
    
    func routeToWelcomePage(segue: UIStoryboardSegue?) {
        popToWelcomePage(source: viewController!, destination: nil)
    }

    //  MARK: Navigation
    func popToWelcomePage(source: HomeViewController, destination: UIViewController?) {
        source.navigationController?.popToRootViewController(animated: true)
    }
    
    func routToTrailerVc(segue: UIStoryboardSegue?) {
        let destinationVC = MovieTrailerViewController()
        var destinationDS = destinationVC.router!.dataStore!
        passDataToTrailerVc(source: dataStore!, destination: &destinationDS)
        navigate(source: viewController!, destination: destinationVC)
    }
    
    func navigate(source: HomeViewController, destination: UIViewController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }

    func present(source: HomeViewController, destination: UIViewController) {
        source.present(destination, animated: true, completion: nil)
    }
    
    // MARK: Passing data
    func passDataToTrailerVc(source: HomeDataStore, destination: inout MovieTrailerDataStore) {
        destination.movieDetails = source.selectedMovieDetails
    }
}
