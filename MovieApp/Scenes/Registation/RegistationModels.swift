//
//  RegistationModels.swift
//  
//
//  Created by Admin on 8/19/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
// FIXME: - Do beter logic

enum Registration {
    
    struct SignInDetail {
        var email: String
        var password: String
    }
    
    enum ErrorMessage: String {
        case allFieldError = "Please fill in all fields"
        case emailError = "Email is not valid"
        case passwordError = "This password is not secure\n The password must be at least 8 characters long and must contain an uppercase Latin letter and a number"
        case passowrdNotConfirmd = "Passwords doesn't match"
    }
    
    // MARK: Use cases
    
    enum GetError {
        struct Request{}
        
        struct Response {}
        
        struct ViewModel {
            var errorModel: ErrorViewModel
        }
    }
    
    enum RegistraitUser {
        struct Request {
            var userInfo: UserData
        }
        struct Response {
            var errorMessage: String?
        }
        struct ViewModel {}
    }
    
    enum SigInUser {
        struct Request {
            var detail: SignInDetail
        }
        struct Response {
            var errorMessage: Error?
        }
        struct ViewModel {}
    }
    
    enum ViewItemVisibility {
        struct Request {
            var tagId: Int?
        }
        struct Response {
            var visibility: Bool
            var id: Int
        }
        struct ViewModel {
            var viewModel: RegistrationViewModel
        }
    }
}
