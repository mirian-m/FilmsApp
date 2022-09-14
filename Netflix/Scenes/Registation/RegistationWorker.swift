//
//  RegistationWorker.swift
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
import FirebaseAuth
import FirebaseDatabase

final class RegistationWorker {
    
    func confirmPassword(_ confirmedPassword: String, _ password: String) -> Bool {
        return confirmedPassword == password
    }
    
    func checkEmailValidation(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func checkPasswordValidation(_ password: String) -> Bool {
        let numberString: [String] = (0...9).map { String($0) }
        let alphabet = [
            "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"
        ]
        return password.trimmingCharacters(in: .whitespaces).count >= 8 &&
            password.map({ alphabet.contains(String($0)) }).contains(true) &&
            password.map({ numberString.contains(String($0)) }).contains(true)
    }
    
    func checkAllFieldsAreFill(_ registrationFields: Registation.RegistratioFormField) -> Bool {
        return !(registrationFields.lastName.trimmingCharacters(in: .whitespaces).isEmpty ||
                    registrationFields.name.trimmingCharacters(in: .whitespaces).isEmpty ||
                    registrationFields.password.trimmingCharacters(in: .whitespaces).isEmpty ||
                    registrationFields.confirmedPassword.trimmingCharacters(in: .whitespaces).isEmpty)
    }
    
    func createUserDataOnFireBase(_ userData: Registation.UserInfo, complition: @escaping (String?) -> Void) {
        Auth.auth().createUser(withEmail: userData.email, password: userData.password) { dataResult, error in
            if  error == nil  {
                let ref = Database.database().reference(fromURL: Constants.API.FireBase.Main.DataBaseUrl)
                ref.child(Constants.API.FireBase.Main.BaseName).child(dataResult!.user.uid).setValue(
                    [
                        Constants.API.FireBase.Key.FirstName: userData.firstName,
                        Constants.API.FireBase.Key.LastName: userData.lastName,
                        Constants.API.FireBase.Key.Email: userData.email,
                        Constants.API.FireBase.Key.WatchedMovies: userData.seenMoviesId
                    ])
            }
            complition(error?.localizedDescription)
        }
    }
    
    func sigIn(_ user: Registation.SignInDetail, complition: @escaping (String?) -> Void) {
        Auth.auth().signIn(withEmail: user.email, password: user.password) { user, error in
            complition(error?.localizedDescription)
        }
    }
}
