import UIKit

final class MovieCell: UITableViewCell {
    
    //  MARK:- Identifier
    static var identifier: String { .init(describing: self) }
    
    //  MARK:- Objects
    private let titleLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 0
        title.textColor = Constants.Design.Color.Primary.White
        title.font = Constants.Design.Font.Sub
        return title
    }()
    
    private let posterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Constants.Content.Category.CornerRadius.min
        imageView.image = Constants.Design.Image.DefaultMovieImage
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  MARK:- Setup
    private func setup(){
        backgroundColor = Constants.Design.Color.Background.None
        tintColor = Constants.Design.Color.Primary.White
        accessoryType = .detailDisclosureButton
        contentView.addSubview(posterImage)
        contentView.addSubview(titleLabel)
        adjustConstraints()
    }
    
    //  MARK:- Constraints
    private func adjustConstraints() {
        let posterImageConstraints = [
            posterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            posterImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            posterImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            posterImage.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        let titleLabelConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: 10),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60)
        ]
        
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(posterImageConstraints)
    }
    
    func configure(with model: MovieViewModel) {
        let url = Constants.API.Movies.Helper.PosterBaseURL + model.imageUrl
        posterImage.getImageFromWeb(by: url)
        titleLabel.text = model.title
    }
}
