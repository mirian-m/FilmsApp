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
    func dispalUpdatedProfileImage(viewModel: Profile.UpdateProfileImage.ViewModel)
    func dispalyAler(viewModel: Profile.GetError.ViewModel)
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
    
    //  MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewController()
        getUserInfo()
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
    
    private func setUpViewController() {
        self.view.addSubview(profileView)
        NotificationCenter.default.addObserver(self, selector: #selector(signOutFromProfile), name: .signOutButtonDidTapped, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(dissmisProfile), name: .cancelButtonDidTapped, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(dissmisProfile), name: .yesButtonWasClickedOnTheBottomSheet, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(chooseImage), name: .imageDidTapped, object: nil)
        
    }
    //  MARK:- Button Action
    @objc private func dissmisProfile() {
        router?.routeBack(segue: nil)
    }
    @objc private func signOutFromProfile() {
        router?.routeToBottomSheet(segue: nil)
    }
    @objc private func chooseImage() {
        showImagePickerControllerActionSheet()
    }
    
    private func showImagePickerControllerActionSheet() {
        let actionSheet = UIAlertController(title: "Choose your Image", message: "", preferredStyle: .actionSheet)
        let photoLibreryAction = UIAlertAction(title: "Choose from librery", style: .default) { _ in
            self.showImagePickerController(sourceType: .photoLibrary)
        }
        let cameraAction = UIAlertAction(title: "Choose from saved photos album", style: .default) { _ in
            self.showImagePickerController(sourceType: .savedPhotosAlbum)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        actionSheet.addAction(photoLibreryAction)
        actionSheet.addAction(cameraAction)
        actionSheet.addAction(cancel)
        present(actionSheet, animated: true, completion: nil)
    }
    //  MARK:- Get user Details from dataBase
    func getUserInfo() {
        let request = Profile.GetUserData.Request()
        interactor?.getUserData(request: request)
    }
}

extension ProfileViewController: ProfileDisplayLogic {
    func dispalyAler(viewModel: Profile.GetError.ViewModel) {
        showAlertWith(title: viewModel.errorModel.title, text: viewModel.errorModel.title)
    }
    
    func dispalUpdatedProfileImage(viewModel: Profile.UpdateProfileImage.ViewModel) {
        profileView.changeProfileImage(image: viewModel.profileImage)
        interactor?.saveProfileImage(request: Profile.SaveProfileImage.Request(image: viewModel.profileImage))
    }
    
    func displayUserDetails(viewModel: Profile.GetUserData.ViewModel) {
        profileView.configure(with: viewModel.profileModel)
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    private func showImagePickerController(sourceType: UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = sourceType
        present(imagePickerController, animated: true, completion: nil)
    }
    
     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        interactor?.updateProfileImage(request: Profile.UpdateProfileImage.Request(info: info))
        dismiss(animated: true, completion: nil)
    }
}

