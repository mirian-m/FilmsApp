//
//  WelcomeInteractor.swift
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

protocol WelcomeBusinessLogic {
    func getSelectedButtonTag(_ tag: Int)
}

protocol WelcomeDataStore {
    var tag: Int { get set }
}

class WelcomeInteractor: WelcomeBusinessLogic, WelcomeDataStore {
//    var presenter: WelcomePresentationLogic?
//    var worker: WelcomeWorker?
    var tag: Int = 0
    
    // MARK: Do something
    func getSelectedButtonTag(_ tag: Int) {
        self.tag = tag
    }
}
