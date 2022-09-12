//  BackgroundImage.swift
//  Netflix
//  Created by Admin on 7/29/22.

import Foundation
import UIKit

class BackgroundImageViewControlller: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        addBackgroundImage()
    }
    
    func addBackgroundImage() {
        UIGraphicsBeginImageContext(self.view.frame.size)
        
//        UIImage(named: "cast")?.draw(in: self.view.bounds)
//
//        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
//
//        UIGraphicsEndImageContext()
//        UIColor(patternImage: image)
        view.backgroundColor = UIColor(red: 0.13, green: 0.122, blue: 0.15, alpha: 1)
    }
}
