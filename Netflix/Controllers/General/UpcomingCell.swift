import UIKit

class UpcomingCell: UITableViewCell {
    static var identifier = "UpcomingCell"
    
    private let playButton: UIButton = {
        var button = UIButton()
        var image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        return button
    }()
    
    private let titleLabel: UILabel = {
        var title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private let posterImage: UIImageView = {
        var image = UIImageView()
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        return image
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(posterImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(playButton)
        applyConstreints()
    }
    func applyConstreints(){
        let playButtonConstraints = [
            playButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            playButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        let titleLabelConstraints = [
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: 10)
        ]
        let posterImageConstraints = [
            posterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            posterImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            posterImage.widthAnchor.constraint(equalToConstant: 100)
        ]
        NSLayoutConstraint.activate(playButtonConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(posterImageConstraints)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: TitleViewModel){
        let url = Constant.PosterBaseURL + model.posterUrl
        posterImage.getImageFromWeb(by: url)
        titleLabel.text = model.titleName
    }
}
