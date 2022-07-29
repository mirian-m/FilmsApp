import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var viewCell: UIView!
    
    private var imageUrl: String?
    
    
    func loadImage(by imageUrl: String) {
        self.posterImage.image = UIImage(named: "defaultImage")
        self.imageUrl = imageUrl
        APIColler.shared.getImageFromWeb(by: imageUrl) { [weak self] (image, url) in
            if (url == self?.imageUrl) {
                self?.posterImage.image = image
            }
        }
    }
}
