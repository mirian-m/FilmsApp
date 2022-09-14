import Foundation
import UIKit

extension String {
    
    //  MARK:- Upercased First letter of string and Return it
    func upperCasedFirstLetter() -> String{
        return self.prefix(1).uppercased() + self.dropFirst()
    }
    
    func createUrl() -> URL? {
        let urlStr = "\(Constants.API.Movies.Main.BaseURL)\(self)\(Constants.API.Movies.Main.API_Key)"
        return URL(string: urlStr)
    }
}

extension UIImageView {
    func getImageFromWeb(by url: String) {
        guard let ApiUrl = URL(string: url) else { return }
        URLSession.shared.dataTask(with: ApiUrl) { (data, _, error) in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.image = image
            }
        }.resume()
    }
}

extension UIButton {
    
    //  MARK:- Set Image To Button With distans
    func setButton(image: UIImage) {
        self.setImage(image, for: .normal)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
        self.contentHorizontalAlignment = .left
        self.imageView?.contentMode = .scaleAspectFit
    }
}

extension UITextField {
    
    //  MARK:- Set to UITextField Left Padding at given points
    func setLeftPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: 0))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}

extension Double {
    
    //  MARK:- Rounds a number to the given precision
    mutating func roundingNumber(at decimal: Int) {
        var  m = 1.0
        for _ in 1...decimal {
            m *= 10
        }
        self = (self * m).rounded() / m
    }
}


extension Notification.Name {
    
    //  MARK:- Create Notification Custom Name
    static let playButtonTap = Notification.Name("Play Button Tapped")
    static let navButtonTap = Notification.Name("Back button Tapped")
    static let textfieldContenVisibilityDidChanged = Notification.Name("textfieldContenVisibilityDidChanged")
}

