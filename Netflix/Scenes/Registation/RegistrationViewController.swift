//
//  RegistationViewController.swift
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

protocol RegistationDisplayLogic: AnyObject {
    func displayViewWithConfig(viewModel: Registation.ViewItemVisibility.ViewModel)
    func displayUserRegistratonAlert(viewModel: Registation.CheckData.ViewModel)
    func displayUserCreationAlert(viewModel: Registation.UserData.ViewModel)
    func displaySigInAlert(viewModel: Registation.SigInUser.ViewModel)
}

final class RegistrationViewController: BackgroundImageViewControlller {
    
    //  MARK:- Clean Components
    var interactor: RegistationBusinessLogic?
    var router: (NSObjectProtocol & RegistationRoutingLogic & RegistationDataPassing)?
    
    //  MARK:- Fields
    static let identifier = "RegistrationViewController"
    lazy var contentView = RegistrationView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
    private var isDoingSigIn: Bool!
    private var registrationIsSuccessful = false
    
    // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(contentView)
        addTargetsFunc()
        doSomething()
    }
    
    //  MARK: Setup
    private func setup() {
        let viewController = self
        let interactor = RegistationInteractor()
        let presenter = RegistationPresenter()
        let router = RegistationRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    func addTargetsFunc() {
        contentView.segmentControl.addTarget(self, action: #selector(setup(_ :)), for: .valueChanged)
        contentView.button.addTarget(self, action: #selector(registrait), for: .touchUpInside)
    }
    
    @objc func setup(_ sender: UISegmentedControl) {
        contentView.segmentControl.isSelected = true
        doSomething()
    }
    
    @objc func registrait(_ sender: UIButton) {
        contentView.button.isEnabled = false
        contentView.button.alpha = 0.5
        contentView.activiteIndicator.startAnimating()
        if isDoingSigIn {
            interactor?.sigInUser(request: Registation.SigInUser.Request(
                                    detail: Registation.SignInDetail(
                                        email: contentView.emailTextField.text ?? "",
                                        password: contentView.passwordTextField.text ?? ""))
            )
        } else {
            let registrationFormField = Registation.RegistratioFormField(
                name: contentView.firstNameTextField.text ?? "",
                lastName: contentView.lastNameTextField.text ?? "",
                email: contentView.emailTextField.text ?? "",
                password: contentView.passwordTextField.text ?? "",
                confirmedPassword: contentView.confirmPasswordTextField.text ?? ""
            )
            
            let request = Registation.CheckData.Request(registrationFormField: registrationFormField)
            interactor?.checkUserFields(request: request)
            
            if registrationIsSuccessful {
                let userData = Registation.UserData.Request(userInfo: Registation.UserInfo(
                                                                firstName: registrationFormField.name,
                                                                lastName: registrationFormField.lastName,
                                                                email: registrationFormField.email,
                                                                password: registrationFormField.password)
                )
                interactor?.createUser(request: userData)
            }
        }
    }
    
    func addSubviewWithAnimation() {
        clearTextFields()
        UIView.animate(withDuration: 1.5) { [weak self] in
            self?.contentView.regitrationStackView.center.x = -self!.view.frame.width
            self?.contentView.button.alpha = 0
            self?.view.addSubview(self!.contentView)
            self?.contentView.button.alpha = 1
        }
    }
    
    func clearTextFields() {
        contentView.firstNameTextField.text = ""
        contentView.emailTextField.text = ""
        contentView.passwordTextField.text = ""
        contentView.confirmPasswordTextField.text = ""
    }
    
    // MARK: Do something
    
    func doSomething() {
        let tagId = contentView.segmentControl.isSelected ? contentView.segmentControl.selectedSegmentIndex : nil
        let request = Registation.ViewItemVisibility.Request(tagId: tagId)
        interactor?.doSomthing(request: request)
    }
    
    func showAlertWith(title: String, text: String) {
        contentView.button.isEnabled = true
        contentView.button.alpha = 1
        contentView.activiteIndicator.stopAnimating()
        let alert = UIAlertController(title: title, message: "\n\(text)", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(action)
        alert.view.tintColor = .red
        present(alert, animated: true, completion: nil)
    }
}

extension RegistrationViewController: RegistationDisplayLogic {
    
    //  MARK: DisplayLogic Methods
    func displayViewWithConfig(viewModel: Registation.ViewItemVisibility.ViewModel) {
        contentView.lastNameTextField.isHidden = viewModel.textFieldVisibility
        contentView.firstNameTextField.isHidden = viewModel.textFieldVisibility
        contentView.confirmPasswordTextField.isHidden = viewModel.textFieldVisibility
        isDoingSigIn = viewModel.textFieldVisibility
        contentView.segmentControl.selectedSegmentIndex = viewModel.selectedSegmentId
        let title = contentView.segmentControl.titleForSegment(at: contentView.segmentControl.selectedSegmentIndex)
        contentView.button.setTitle(title, for: .normal)
        isDoingSigIn = viewModel.textFieldVisibility
        addSubviewWithAnimation()
    }
    
    func displayUserRegistratonAlert(viewModel: Registation.CheckData.ViewModel) {
        guard let errorMessage = viewModel.errorMessage else {
            registrationIsSuccessful = true
            return
        }
        registrationIsSuccessful = false
        showAlertWith(title: AlerTitle.Error.registration, text: errorMessage)
    }
    
    func displayUserCreationAlert(viewModel: Registation.UserData.ViewModel) {
        if viewModel.errorMessage != nil {
            showAlertWith(title: AlerTitle.Error.createUser, text: viewModel.errorMessage!)
        } else {
            router?.routeToHomeVC(segue: nil)
        }
    }
    
    func displaySigInAlert(viewModel: Registation.SigInUser.ViewModel) {
        if viewModel.errorMessage != nil {
            showAlertWith(title: AlerTitle.Error.sigIn, text: viewModel.errorMessage!)
        } else {
            router?.routeToHomeVC(segue: nil)
        }
    }

    
}
