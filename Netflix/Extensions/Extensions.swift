
import Foundation
import UIKit


extension String{
    func upperCasedFirstLetter() -> String{
        return self.prefix(1).uppercased() + self.dropFirst()
    }
}
extension UIImageView {
    func getImageFromWeb(by url: String){
        guard let ApiUrl = URL(string: url) else {return}
        URLSession.shared.dataTask(with: ApiUrl) { (data, _, error) in
            guard let data = data, error == nil else {return}
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.image = image
            }
        }.resume()
    }
}

