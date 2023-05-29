import UIKit

extension String {
    //  MARK:- Upercased First letter of string and Return it
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

extension Notification.Name {
    //  MARK:- Create Notification Custom Name
    static let playButtonWasClicked = Notification.Name("Play Button Tapped")
    static let moveBackButtonTapped = Notification.Name("Back button Tapped")
    static let textfieldContenVisibilityDidChanged = Notification.Name("textfieldContenVisibilityDidChanged")
    static let signOutButtonDidTapped = Notification.Name("signOutButtonDidTapped")
    static let yesButtonWasClickedOnTheBottomSheet = Notification.Name("yesButtonTapped")
    static let cancelButtonDidTapped = Notification.Name("cancelButtonDidTapped")
    static let imageDidTapped = Notification.Name("Image view tapped")
}


extension UIViewController {
    //  Alert Func For View Controllers
    func showAlertWith(title: String, text: String) {
        let alert = UIAlertController(title: title, message: "\n\(text)", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(action)
        alert.view.tintColor = .red
        present(alert, animated: true, completion: nil)
    }
}
