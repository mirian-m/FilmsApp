import UIKit

class SearchCollectionViewcell: UICollectionViewCell {
    static var identifier = "SearchCollectionViewcell"
    
    var posterImage: UIImageView = {
        var image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        addSubview(posterImage)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super .layoutSubviews()
        posterImage.frame = bounds
    }
}
