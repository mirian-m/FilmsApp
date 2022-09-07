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
        self.firstName = dictionary[RegistrationField.firstName.rawValue] as? String ?? ""
        self.lastName = dictionary[RegistrationField.lastName.rawValue] as? String ?? ""
        self.email = dictionary[RegistrationField.email.rawValue] as? String ?? ""
        self.seenMoviesList = dictionary[RegistrationField.watchedMovies.rawValue] as? [Int] ?? []
    }
}
