//
//  ProfileViewController.swift
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

protocol ProfileDisplayLogic: AnyObject {
    func displayUserDetails(viewModel: Profile.GetUserData.ViewModel)
}

final class ProfileViewController: UIViewController {
    
    //  MARK:- Clean components
    var interactor: ProfileBusinessLogic?
    var router: (NSObjectProtocol & ProfileRoutingLogic & ProfileDataPassing)?
    
    private lazy var profileView = ProfileView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
    
    // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    private func setup() {
        let viewController = self
        let interactor = ProfileInteractor()
        let presenter = ProfilePresenter()
        let router = ProfileRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    //  MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(profileView)
        NotificationCenter.default.addObserver(self, selector: #selector(signOutFromProfile), name: .signOutButtonDidTapped, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(dissmisProfile), name: .cancelButtonDidTapped, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(dissmisProfile), name: .yesButtonWasClickedOnTheBottomSheet, object: nil)
        getUserInfo()
    }
    
    //  MARK:- Cancel Button Action
    @objc private func dissmisProfile() {
        router?.routeBack(segue: nil)
    }
    @objc func signOutFromProfile() {
        router?.routeToBottomSheet(segue: nil)
    }
    
    //  MARK:- Get user Details from dataBase
    func getUserInfo() {
        let request = Profile.GetUserData.Request()
        interactor?.getUserData(request: request)
    }
}

extension ProfileViewController: ProfileDisplayLogic {
    func displayUserDetails(viewModel: Profile.GetUserData.ViewModel) {
        profileView.configure(with: viewModel.profileModel)
    }
}
