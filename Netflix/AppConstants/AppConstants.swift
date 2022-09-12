//
//  App.swift
//  Netflix
//
//  Created by Admin on 9/12/22.
//

import Foundation
import UIKit

//  Using case-less enum
enum Constants {
    
    enum Design {
        
        enum Color {
            
            enum Primary {
                static let White = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
                static let WhiteDisable = UIColor(red: 0.74, green: 0.74, blue: 0.74, alpha: 1)
            }
            
            enum Background {
                static let Light = UIColor(red: 0.13, green: 0.122, blue: 0.15, alpha: 1)
                static let Dark = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
                static let None = UIColor(white: 1, alpha: 0)
            }
        }
        
        enum Image {
            static let IconHome = UIImage(systemName: "house.fill")
            static let IconPerson = UIImage(systemName: "person.fill")
            static let IconStar = UIImage(systemName: "star.fill")
            static let IconClock = UIImage(systemName: "clock")
        }
        
        enum Font {
            static let HeadingOne = UIFont.systemFont(ofSize: 24, weight: .medium)
            static let HeadingTwo = UIFont.systemFont(ofSize: 18, weight: .medium)
            static let HeadingThree = UIFont.systemFont(ofSize: 16, weight: .medium)
            static let Body = UIFont.systemFont(ofSize: 15, weight: .regular)
            static let Sub = UIFont.systemFont(ofSize: 13, weight: .regular)
            
        }
    }
    
    enum Content {
        
        enum Category {
            
            enum Height {
                static let max: CGFloat = 200
                static let middle: CGFloat = 150
                static let min: CGFloat = 120
            }
            
            enum CornerRadius {
                static let max: CGFloat = 15
                static let middle: CGFloat = 10
                static let min: CGFloat = 5
            }
        }
    }
    
    enum API{
        
        
    }
    
}

