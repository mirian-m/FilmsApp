//
//  UserManagerService.swift
//  Netflix
//
//  Created by Admin on 9/13/22.
//

import Foundation
import UIKit
import Firebase

class UserManger {
    static let shared = UserManger()
    
    private init() {}
    
    private func getUserData(by userId: String, complition: @escaping (UserData) -> Void) {
        let ref = Database.database().reference(fromURL: Constants.API.FireBase.Main.DataBaseUrl)
        ref.child(Constants.API.FireBase.Main.Name).child(userId).observeSingleEvent(of: .value, with: { data in
            guard let value = data.value as? Dictionary<String, Any> else { return }
            let user = UserData(with: value)
            complition(user)
        })
    }
    
    func updateUserData(userId: String, data: Dictionary<String, Any>) {
        let ref = Database.database().reference(fromURL: Constants.API.FireBase.Main.DataBaseUrl)
        ref.child(Constants.API.FireBase.Main.Name).child(userId).updateChildValues(data) { (error, DatabaseReference) in
            if error != nil {
                print(error!.localizedDescription )
            }
        }
    }
    
    func getSigInUserData(compilition: @escaping (UserData) -> Void) {
        guard let currentUser = Auth.auth().currentUser else { return }
        UserManger.shared.getUserData(by: currentUser.uid) {  userData in
            compilition(userData)
        }
    }

}
