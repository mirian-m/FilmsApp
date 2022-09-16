//
//  ProfileInteractor.swift
//  Netflix
//
//  Created by Admin on 9/16/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ProfileBusinessLogic {
    func getUserData(request: Profile.GetUserData.Request)
}

protocol ProfileDataStore {
    //var name: String { get set }
}

final class ProfileInteractor: ProfileBusinessLogic, ProfileDataStore {
    var presenter: ProfilePresentationLogic?
    var worker: ProfileWorker?
    //var name: String = ""
    
    // MARK: Do something
    
    func getUserData(request: Profile.GetUserData.Request) {
        UserManger.shared.getSigInUserData { userData in
            DispatchQueue.main.async { [weak self] in
                let response = Profile.GetUserData.Response(userData: userData)
                self?.presenter?.presentUserDetails(response: response)
            }
        }
    }
}
