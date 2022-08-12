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
    var user: UserData?
    
    func fetchUser() {
        let db = Firestore.firestore()
        let ref = db.collection("Users")
        ref.getDocuments(completion: { snapshot, error in
            guard error == nil else {
                print ("error")
                return
            }
//            if let snapshot = snapshot {
//                snapshot.documents.filter { doqument in
//                    doqument.documentID == user.user
//                }
//                for document in snapshot.documents {
                    
//                    if document.documentID == user?.user.uid {
//                        let userData = document.data()
//                        user.lastName = (userData["lastName"] as? String) ?? ""
//                        self?.signInUserData.firstName = (userData["firstName"] as? String) ?? ""
//                        self?.signInUserData.mail = (userData["mail"] as? String) ?? ""
//                        self?.signInUserData.seenMoviesList = (userData["movies"] as? [Int]) ?? []
//
//                    }
//                }
//            }
        })

    }
    
}
