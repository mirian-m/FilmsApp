//
//  UserManagerService.swift
//  
//
//  Created by Admin on 9/13/22.
//

import Foundation
import UIKit
import Firebase

final class FireBaseManager {
    static let shared = FireBaseManager()
    
    private init() {}
    
    private func getUserData(by userId: String, completion: @escaping (UserData) -> Void) {
        let ref = Database.database().reference(fromURL: Constants.API.FireBase.Main.DataBaseUrl)
        ref.child(Constants.API.FireBase.Main.BaseName).child(userId).observeSingleEvent(of: .value, with: { data in
            guard let value = data.value as? Dictionary<String, Any> else { return }
            let user = UserData(with: value)
            completion(user)
        })
    }
    
    func updateUserData(userId: String, data: Dictionary<String, Any>, completion: @escaping (Error?) -> Void) {
        let ref = Database.database().reference(fromURL: Constants.API.FireBase.Main.DataBaseUrl)
        ref.child(Constants.API.FireBase.Main.BaseName).child(userId).updateChildValues(data) { (error, DatabaseReference) in
            completion(error)
        }
    }
    
    func getSigInUserData(completion: @escaping (UserData) -> Void) {
        guard let currentUser = Auth.auth().currentUser else { return }
        FireBaseManager.shared.getUserData(by: currentUser.uid) {  userData in
            completion(userData)
        }
    }
}
