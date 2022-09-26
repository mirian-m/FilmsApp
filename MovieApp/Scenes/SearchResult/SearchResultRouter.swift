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

protocol SearchResultRoutingLogic {
    func routeToDetailsVc()
}

protocol SearchResultDataPassing {
    var dataStore: SearchResultDataStore? { get }
}

final class SearchResultRouter: NSObject, SearchResultRoutingLogic, SearchResultDataPassing {
    
    //  MARK:- Clean Components
    weak var viewController: SearchResultViewController?
    var dataStore: SearchResultDataStore?
    
    //  MARK: Routing
    func routeToDetailsVc() {
        let destinationVC = DetailsViewController()
        destinationVC.modalPresentationStyle = .fullScreen
        guard var destinationDS = destinationVC.router?.dataStore,
              let dataStore = dataStore,
              let viewController = self.viewController
        else { return }
        passDataToDetailsVc(source: dataStore, destination: &destinationDS)
        presentDetailsVc(source: viewController, destination: destinationVC)
    }
    
    //  MARK: Navigation
    private func presentDetailsVc(source: SearchResultViewController, destination: UIViewController) {
        source.present(destination, animated: true, completion: nil)
    }
    
    //  MARK: Passing data
    private func passDataToDetailsVc(source: SearchResultDataStore, destination: inout DetailsDataStore) {
        destination.movieId = source.selectedMovieId
    }
}
