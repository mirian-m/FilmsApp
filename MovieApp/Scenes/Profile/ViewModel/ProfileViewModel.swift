//
//  ProfileViewModel.swift
//  
//
//  Created by Admin on 9/16/22.
//

import Foundation

struct ProfileViewModel {
    var name: String
    var surName: String
    var email: String
    var profileImageUrl: String
    
    init(with model: UserData) {
        self.name = model.firstName
        self.surName = model.lastName
        self.email = model.email
        self.profileImageUrl = model.profileImageUrl 
    }
}
