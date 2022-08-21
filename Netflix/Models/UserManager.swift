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
        let ref = Database.database().reference(fromURL: Constant.firebaseDataBaseReferrensUrl)
        ref.child("Users").child(userId).observeSingleEvent(of: .value, with: { data in
            guard let value = data.value as? NSDictionary else { return }
            let user = UserData(firstName: value["firstName"] as? String ?? "",
                                lastName: value["lastName"] as? String ?? "",
                                mail: value["email"] as? String ?? "",
                                password: "",
                                seenMoviesList: value["movies"] as? [Int] ?? [])
            complition(user)
        })
    }
}
