import Foundation
import UIKit

extension String{
    func upperCasedFirstLetter() -> String{
        return self.prefix(1).uppercased() + self.dropFirst()
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
    func setButton(image: UIImage) {
        self.setImage(image, for: .normal)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
        self.contentHorizontalAlignment = .left
        self.imageView?.contentMode = .scaleAspectFit
    }
}

extension String {
    func createAttributedString() -> NSMutableAttributedString {
        let color = UIColor.red;
//        let textToFind = "redword"
        let attrsString =  NSMutableAttributedString(string: self);
        // search for word occurrence
//        let range = (self as NSString).range(of: textToFind)
//        if (range.length > 0) {
        attrsString.addAttribute(NSAttributedString.Key.foregroundColor,value: color, range: _NSRange())
//        }
        print(attrsString)
        return attrsString
        // set attributed text
    }
}
