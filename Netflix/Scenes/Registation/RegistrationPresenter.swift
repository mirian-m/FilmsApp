//
//  RegistationPresenter.swift
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

protocol RegistrationPresentationLogic {
    func presentSomething(response: Registration.ViewItemVisibility.Response)
    func presentRegistrationMessage(response: Registration.RegistraitUser.Response)
    func presentSignMessage(response: Registration.SigInUser.Response)
}

final class RegistrationPresenter  {
    weak var viewController: RegistrationDisplayLogic?
}

extension RegistrationPresenter: RegistrationPresentationLogic {
    
    // MARK:- RegistrationPresentationLogic Methods
    func presentSomething(response: Registration.ViewItemVisibility.Response) {
        viewController?.displayView(
            viewModel: Registration.ViewItemVisibility.ViewModel(
                viewModel: RegistrationViewModel(
                    textFieldVisibility: response.visibility,
                    selectedSegmentId: response.id)))
    }
    
    func presentSignMessage(response: Registration.SigInUser.Response) {
        guard response.errorMessage == nil else {
            viewController?.displayAlert(viewModel: Registration.GetError.ViewModel(
                                            errorModel: ErrorViewModel(
                                                title: AlerTitle.Error.sigIn,
                                                message: response.errorMessage!.localizedDescription)))
//            viewController?.displayAlert(viewModel: Registration.GetError.ViewModel(title: AlerTitle.Error.sigIn, errorMessage: response.errorMessage!.localizedDescription))
            return
        }
        viewController?.displayHome(viewModel: Registration.SigInUser.ViewModel())
    }
    
    func presentRegistrationMessage(response: Registration.RegistraitUser.Response) {
        guard response.errorMessage == nil else {
            viewController?.displayAlert(viewModel: Registration.GetError.ViewModel(errorModel: ErrorViewModel(title: AlerTitle.Error.registration, message: response.errorMessage!)))
            return
        }
        viewController?.displayHome(viewModel: Registration.SigInUser.ViewModel())
    }
}

