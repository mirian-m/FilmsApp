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
    private var user: UserData?
    
    func getSigInUserData() -> UserData? {
        self.user ?? nil
    }
    
    func getUser(data: QueryDocumentSnapshot) {
        let userData = data.data()
        user?.lastName = (userData["lastName"] as? String) ?? ""
        user?.firstName = (userData["firstName"] as? String) ?? ""
        user?.mail = (userData["mail"] as? String) ?? ""
        user?.seenMoviesList = (userData["movies"] as? [Int]) ?? []
    }
}
