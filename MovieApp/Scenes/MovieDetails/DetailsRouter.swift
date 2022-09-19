//
//  DetailsRouter.swift
//  Netflix
//
//  Created by Admin on 9/8/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol DetailsRoutingLogic {
    func routeToTraileVc(segue: UIStoryboardSegue?)
    func routeToBack(segue: UIStoryboardSegue?)
}

protocol DetailsDataPassing {
    var dataStore: DetailsDataStore? { get }
}

final  class DetailsRouter: NSObject, DetailsDataPassing {
    
    //  MARK:- Clean Components
    weak var viewController: DetailsViewController?
    var dataStore: DetailsDataStore?
}

extension DetailsRouter:  DetailsRoutingLogic {
    func routeToBack(segue: UIStoryboardSegue?) {
        popVc(source: viewController!)
    }
    // MARK: Routing
    func routeToTraileVc(segue: UIStoryboardSegue?) {
        let destinationVC = MovieTrailerViewController()
        var destinationDS = destinationVC.router!.dataStore!
        passDataToTrailerVc(source: dataStore!, destination: &destinationDS)
        navigateToTrailerVc(source: viewController!, destination: destinationVC)
    }
    
    //     MARK: Navigation
    func navigateToTrailerVc(source: DetailsViewController, destination: UIViewController) {
        source.show(destination, sender: nil)
    }
    
    // MARK: Passing data
    func passDataToTrailerVc(source: DetailsDataStore, destination: inout MovieTrailerDataStore) {
        destination.movieDetails = source.movieDetails
    }
    
    func popVc(source: UIViewController) {
        source.dismiss(animated: true, completion: nil)
    }
}