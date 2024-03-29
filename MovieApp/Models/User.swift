//  User.swift
//  

import UIKit

struct UserData {
    var firstName: String
    var lastName: String
    var email: String
    var password: String
    var confirmedPassword: String
    var profileImageUrl: String
    var seenMoviesList: [Int]
    
    
    init(firstName: String, lastName: String, email: String, password: String = "", confirmedPassword: String = "", profileImageUrl: String = "", seenMoviesList: [Int] = []) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.password = password
        self.confirmedPassword = confirmedPassword
        self.profileImageUrl = profileImageUrl
        self.seenMoviesList = seenMoviesList
    }
    
    init(with dictionary: Dictionary<String, Any>) {
        self.init(firstName: dictionary[Constants.API.FireBase.Key.FirstName] as? String ?? "",
                  lastName: dictionary[Constants.API.FireBase.Key.LastName] as? String ?? "",
                  email: dictionary[Constants.API.FireBase.Key.Email] as? String ?? "",
                  profileImageUrl: dictionary[Constants.API.FireBase.Key.ProfileImageUrl] as? String ?? "",
                  seenMoviesList: dictionary[Constants.API.FireBase.Key.WatchedMovies] as? [Int] ?? []
        )
    }
}
