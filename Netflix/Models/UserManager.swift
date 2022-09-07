//
//  UserManager.swift
//  Netflix
//
//  Created by Admin on 8/8/22.
//

import Foundation
import UIKit
import Firebase

class UserManger {
    static let shared = UserManger()

    func getUserData(by userId: String, complition: @escaping (UserData) -> Void) {
        let ref = Database.database().reference(fromURL: APIConstants.firebaseDataBaseReferencUrl)
        ref.child(RegistrationField.users.rawValue).child(userId).observeSingleEvent(of: .value, with: { data in
            guard let value = data.value as? Dictionary<String, Any> else { return }
            let user = UserData(with: value)
            complition(user)
        })
    }
    
    func updateUserData(userId: String, data: Dictionary<String, Any>) {
        let ref = Database.database().reference(fromURL: APIConstants.firebaseDataBaseReferencUrl)
        ref.child(RegistrationField.users.rawValue).child(userId).updateChildValues(data) { (error, DatabaseReference) in
            if error != nil {
                print(error!.localizedDescription )
            }
        }
    }

}
