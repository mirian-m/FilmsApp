//
//  App.swift
//  Netflix
//
//  Created by Admin on 9/12/22.
//

import Foundation
import UIKit

//  MARK:- Case-less enum for Constants
enum Constants {
    
    //  MARK:- Design
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
            static let DefaultMovieImage = UIImage(named: "defaultImage")
            static let DefaultProfileImage = UIImage(systemName: "person")
            
            enum Logo {
                static let LogoImageOne = UIImage(named: "Netflix-new")
                static let LogoImageTwo = UIImage(named: "NetflixLogo")
            }
            
            enum Icon {
                static let Back = UIImage(systemName: "chevron.backward")
                static let Play = UIImage(named: "PlayIcon")
                static let Home = UIImage(systemName: "house.fill")
                static let Person = UIImage(systemName: "person.fill")
                static let Star = UIImage(systemName: "star.fill")
                static let Clock = UIImage(systemName: "clock")
                static let Eye = UIImage(systemName: "eye")
                static let EyeSlash = UIImage(systemName: "eye.slash")
                static let SigOut = UIImage(systemName: "arrowshape.turn.up.right")
            }
        }
        
        enum Font {
            static let HeadingOne = UIFont.systemFont(ofSize: 24, weight: .medium)
            static let HeadingTwo = UIFont.systemFont(ofSize: 18, weight: .medium)
            static let HeadingThree = UIFont.systemFont(ofSize: 16, weight: .medium)
            static let Body = UIFont.systemFont(ofSize: 15, weight: .regular)
            static let Sub = UIFont.systemFont(ofSize: 13, weight: .regular)
        }
    }
    
    //  MARK:- Content Constants
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
    
    //  MARK:- API
    enum API {
        
        enum FireBase {
            
            enum Main {
                static let DataBaseUrl = "https://netflixclone-343110-default-rtdb.firebaseio.com/"
                static let BaseName = "Users"
                static let StorageFileName = "profileImages"
            }
            
            enum Key {
                static var FirstName = "firstName"
                static var LastName = "lastName"
                static var Email = "email"
                static var ProfileImageUrl = "profileImageUrl"
                static var WatchedMovies = "watchedMovies"
            }
        }
        
        enum Movies {
            
            enum Main {
                static let BaseURL = "https://api.themoviedb.org"
                static let API_Key = "793b50b3b4c6ef37ce18bda27b1cbf67"
                static let EndUrl = "&language=en-US"
            }
            
            enum Helper {
                static let PosterBaseURL = "https://image.tmdb.org/t/p/w500/"
                static let YoutubeAPI_KEY = "AIzaSyCFAeVXHQbpbirLUloOmQwuUJBkavE-2rQ"
                static let YoutubeBaseUrl = "https://youtube.googleapis.com/youtube/v3/search?"
            }
        }
    }
}

public enum APICollerError: String, Error {
    case faldeToGetData = "Falde To get data"
}

enum AlerTitle {
    enum Error {
        static var error = "Error"
        static var registration = "Registration Error"
        static var createUser = "Create User Error"
        static var sigIn = "Sig In Error"
    }
}



