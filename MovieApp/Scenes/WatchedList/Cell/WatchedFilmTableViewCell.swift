//
//  WatchedFilmTableViewCell.swift
//  Netflix
//
//  Created by Admin on 9/7/22.
//

import UIKit

protocol WatchedFilmTableViewCellDelegate: AnyObject {
    func removeMovieFromList(by movieId: Int)
}

class WatchedFilmTableViewCell: UITableViewCell {
    static var identifier: String { .init(describing: self) }
    
    //  MARK:- Properties
    private var genreButtons = [UIButton]()
    weak var delegate: WatchedFilmTableViewCellDelegate?
    private var filmId = 0
    
    //  MARK:- Create objects Programmatically
    private lazy var customView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Constants.Content.Category.CornerRadius.max
        view.backgroundColor = Constants.Design.Color.Background.Dark
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 0
        title.textColor = Constants.Design.Color.Primary.White
        title.font = Constants.Design.Font.HeadingTwo
        return title
    }()
    
    private lazy var genresStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = .zero
//        stack.vie
        stack.addArrangedSubview(firstGenre)
        stack.addArrangedSubview(secondGenre)
        stack.addArrangedSubview(thirdGenre)
        return stack
    }()
    
    private lazy var firstGenre: UIButton = {
        let button = UIButton()
        button.setDesign()
        button.tag = 0
        self.genreButtons.append(button)
        return button
    }()
    
    private lazy var secondGenre: UIButton = {
        let button = UIButton()
        button.setDesign()
        button.tag = 1
        self.genreButtons.append(button)
        return button
    }()
    
    private lazy var thirdGenre: UIButton = {
        let button = UIButton()
        button.setDesign()
        button.tag = 2
        self.genreButtons.append(button)
        return button
    }()
    
    private lazy var removeBtn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "xmark.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        button.setImage(image, for: .normal)
        button.tintColor = .red
        button.addTarget(self, action: #selector(removeMovieFromList), for: .touchUpInside)
        return button
    }()
    
    private let starLogoBtn: UIButton = {
        let button = UIButton()
        button.setImage(Constants.Design.Image.IconStar?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var voteLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.numberOfLines = 0
        lb.textColor =  Constants.Design.Color.Primary.White
        lb.textAlignment = .left
        lb.font = Constants.Design.Font.Sub
        return lb
    }()
    
    private lazy var posterImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.image = UIImage(named: "defaultImage")
        image.layer.cornerRadius = 10
        return image
    }()
    
    //  MARK:- Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = Constants.Design.Color.Background.None
        addItemsToView()
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  MARK:- Setup
    func addItemsToView() {
        customView.addSubview(titleLabel)
        customView.addSubview(removeBtn)
        customView.addSubview(starLogoBtn)
        customView.addSubview(voteLb)
        customView.addSubview(genresStackView)
        contentView.addSubview(customView)
        contentView.addSubview(posterImage)
    }
    
    func configure(with model: MovieViewModel) {
        let url = Constants.API.Movies.Helper.PosterBaseURL + model.imageUrl
        self.filmId = model.id
        posterImage.getImageFromWeb(by: url)
        titleLabel.text = model.title
        voteLb.text = "\(round(number: model.rate))/10"
        genreButtons.forEach { button in
            set(title: model.genres, for: button)
        }
    }
    
    //  MARK:- Constraints
    func applyConstraints() {
        
        let customViewConstraints = [
            customView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            customView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            customView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            customView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
        ]
        
        let genresStackViewConstaints = [
            genresStackView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            genresStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            genresStackView.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -5),
        ]
        
        let removeBtnConstraints = [
            removeBtn.topAnchor.constraint(equalTo: customView.topAnchor, constant: -5),
            removeBtn.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: 5),
            removeBtn.widthAnchor.constraint(equalToConstant: 30),
            removeBtn.heightAnchor.constraint(equalToConstant: 30)
        ]
        
        let titleLabelConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 130),
            titleLabel.topAnchor.constraint(equalTo: customView.topAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -10)
        ]
        
        let starImageConstraints = [
            starLogoBtn.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            starLogoBtn.bottomAnchor.constraint(equalTo: customView.bottomAnchor, constant: -10),
            starLogoBtn.heightAnchor.constraint(equalToConstant: 20),
            starLogoBtn.widthAnchor.constraint(equalToConstant: 20)
        ]
        
        let voteLbCostraints = [
            voteLb.leadingAnchor.constraint(equalTo: starLogoBtn.trailingAnchor, constant: 5),
            voteLb.centerYAnchor.constraint(equalTo: starLogoBtn.centerYAnchor)
        ]
        
        let posterImageConstraints = [
            posterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            posterImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            posterImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            posterImage.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        //  MARK:- Activate Constraints
        NSLayoutConstraint.activate(customViewConstraints)
        NSLayoutConstraint.activate(genresStackViewConstaints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(starImageConstraints)
        NSLayoutConstraint.activate(removeBtnConstraints)
        NSLayoutConstraint.activate(voteLbCostraints)
        NSLayoutConstraint.activate(posterImageConstraints)
    }
}

extension WatchedFilmTableViewCell {
    
    //  MARK:- Set Title for Genre Buttons
    private func set(title genre: [Genres], for button: UIButton) {
        guard let titleForButton = getGenre(by: button.tag, from: genre) else {
            button.alpha = 0
            return
        }
        button.setTitle(titleForButton, for: .normal)
    }
    
    private func getGenre(by index: Int, from genre: [Genres]) -> String? {
        return (index < genre.count) ? genre[index].name == "Science Fiction" ? "Sci-Fi" : genre[index].name : nil
    }
    
    //  MARK:- Private Functions
    private func round(number: Double) -> Double {
        var roundedNumber = number
        roundedNumber.roundingNumber(at: 1)
        return roundedNumber
    }
    
    //  MARK:- Button Actions
    @objc func removeMovieFromList() {
        delegate?.removeMovieFromList(by: filmId)
    }
}

extension UIButton {
    
    //  MARK:- Set design for Genre button
    fileprivate func setDesign() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.contentHorizontalAlignment = .leading
        self.tintColor = Constants.Design.Color.Primary.White
        self.titleLabel?.font = Constants.Design.Font.Sub
        self.setTitle("Action", for: .normal)
    }
}
