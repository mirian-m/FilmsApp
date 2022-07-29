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
        UIImage(named: "cast")?.draw(in: self.view.bounds)
        
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        view.backgroundColor = UIColor(patternImage: image)
    }
}
