//
//  ProfileWorker.swift
//  Netflix
//
//  Created by Admin on 9/16/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import FirebaseStorage
import FirebaseAuth

final class ProfileWorker {
    private let storage = Storage.storage()
    
    func saveImageToFireBaseStorage(image: UIImage, completion: @escaping (Error?) -> Void) {
        guard let imageData = image.pngData() else { return }
        storage.reference().child(Constants.API.FireBase.Main.StorageFileName + "/\(Auth.auth().currentUser!.uid).png").putData(imageData, metadata: nil) { _, error in
            guard error == nil else {
                completion(error)
                return
            }
            self.storage.reference().child(Constants.API.FireBase.Main.StorageFileName + "/\(Auth.auth().currentUser!.uid).png").downloadURL { (url, error) in
                guard let url = url?.absoluteString, error == nil else {
                    completion(error)
                    return
                }
                UserManger.shared.updateUserData(userId: Auth.auth().currentUser!.uid, data: [Constants.API.FireBase.Key.ProfileImageUrl: url]) { error in
                    completion(error)
                }
            }
        }
    }
}
