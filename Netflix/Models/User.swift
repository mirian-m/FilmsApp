//  User.swift
//  Netflix
//  Created by Admin on 7/30/22.

import Foundation
import UIKit

struct UserData {
    var firstName: String
    var lastName: String
    var email: String
    var password: String = ""
    var seenMoviesList: [Int]
    
    init(with dictionary: Dictionary<String, Any>) {
        self.firstName = dictionary[Constants.API.FireBase.Key.FirstName] as? String ?? ""
        self.lastName = dictionary[Constants.API.FireBase.Key.LastName] as? String ?? ""
        self.email = dictionary[Constants.API.FireBase.Key.Email] as? String ?? ""
        self.seenMoviesList = dictionary[Constants.API.FireBase.Key.WatchedMovies] as? [Int] ?? []
    }
}
