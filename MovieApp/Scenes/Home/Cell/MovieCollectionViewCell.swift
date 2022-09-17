import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView! {
        didSet {
            posterImageView.layer.cornerRadius = Constants.Content.Category.CornerRadius.min
        }
    }
    @IBOutlet weak var viewCell: UIView!
    
    private var imageUrl: String?
    
    func loadImage(by imageUrl: String) {
        self.posterImageView.image = Constants.Design.Image.DefaultImage
        self.imageUrl = imageUrl
        NetworkService.shared.getImageFromWeb(by: imageUrl) { [weak self] (image, url) in
            if (url == self?.imageUrl) {
                self?.posterImageView.image = image
            }
        }
    }
}
