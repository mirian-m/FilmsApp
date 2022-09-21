//
//  RegistationRouter.swift
//  Netflix
//
//  Created by Admin on 8/19/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol RegistationRoutingLogic {
    func routeToHomeVC(segue: UIStoryboardSegue?)
}

protocol RegistrationDataPassing {
    var dataStore: RegistationDataStore? { get }
}

final class RegistationRouter: NSObject, RegistationRoutingLogic, RegistrationDataPassing {
    weak var viewController: RegistrationViewController?
    var dataStore: RegistationDataStore?
    
    // MARK: Routing
    
    func routeToHomeVC(segue: UIStoryboardSegue?) {
        guard let destinationVC = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "TabBarController")
                as? UITabBarController else { return }
        navigateToHomeVC(source: viewController!, destination: destinationVC)
    }
    
    // MARK: Navigation
    private func navigateToHomeVC(source: RegistrationViewController, destination: UIViewController) {
        source.show(destination, sender: nil)
    }
}
