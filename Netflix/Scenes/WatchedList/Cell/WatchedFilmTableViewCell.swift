//
//  WatchedFilmTableViewCell.swift
//  Netflix
//
//  Created by Admin on 9/7/22.
//

import UIKit

protocol WatchedFilmTableViewCellDelegate: AnyObject {
    func genreInCellDidTapped(genre: Genres)
    func removeMovieFromList(by movieId: Int)
}

class WatchedFilmTableViewCell: UITableViewCell {
    static var identifier = "WatchedFilmTableViewCell"
    
    //  MARK:- Properties
    private var genreButtons = [UIButton]()
    weak var delegate: WatchedFilmTableViewCellDelegate?
    private var filmGenre = [Genres]()
    private var filmId = 0
    
    //  MARK:- Create objects Programmatically
    private lazy var customView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 0
        title.textColor = UIColor.white
        title.font = title.font.withSize(Constans.fontSize)
        return title
    }()
    
    private lazy var stackViewForButtons: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 4
        stack.addArrangedSubview(firstGenre)
        stack.addArrangedSubview(secondGenre)
        stack.addArrangedSubview(thirdGenre)
        return stack
    }()
    
    private lazy var firstGenre: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.gray.cgColor
        button.tag = 0
        button.setTitle("Action", for: .normal)
        button.titleLabel?.font = UIFont(descriptor: UIFontDescriptor(), size: Constans.fontSize)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.addTarget(self, action: #selector(genreButtonTapped), for: .touchUpInside)
        self.genreButtons.append(button)
        return button
    }()
    
    private lazy var secondGenre: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.gray.cgColor
        button.tag = 1
        button.setTitle("Action", for: .normal)
        button.titleLabel?.font = UIFont(descriptor: UIFontDescriptor(),  size: Constans.fontSize)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.addTarget(self, action: #selector(genreButtonTapped), for: .touchUpInside)
        self.genreButtons.append(button)
        return button
    }()
    
    private lazy var thirdGenre: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.gray.cgColor
        button.tag = 2
        button.setTitle("Action", for: .normal)
        button.titleLabel?.font = UIFont(descriptor: UIFontDescriptor(), size: Constans.fontSize)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.addTarget(self, action: #selector(genreButtonTapped), for: .touchUpInside)
        self.genreButtons.append(button)
        return button
    }()
    
    private lazy var removeBtn: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "xmark.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .red
        button.addTarget(self, action: #selector(removeMovieFromList), for: .touchUpInside)
        return button
    }()
    
    private let star: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "star.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20))
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .systemGray
        return button
    }()
    
    private lazy var voteLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.numberOfLines = 0
        lb.textColor = UIColor.white
        lb.textAlignment = .left
        lb.font = lb.font.withSize(13)
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
        backgroundColor = UIColor(white: 1, alpha: 0)
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
        customView.addSubview(star)
        customView.addSubview(voteLb)
        customView.addSubview(stackViewForButtons)
        contentView.addSubview(customView)
        contentView.addSubview(posterImage)
    }
    
    func configure(with model: MovieViewModel) {
        self.filmGenre = model.genres
        self.filmId = model.id
        let url = APIConstants.posterBaseURL + model.imageUrl
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
        
        let stackViewForButtonsConstaints = [
            stackViewForButtons.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            stackViewForButtons.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            stackViewForButtons.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -5)
        ]
        let firstGenreConstraints = [
            firstGenre.widthAnchor.constraint(equalToConstant: 35)
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
            star.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            star.bottomAnchor.constraint(equalTo: customView.bottomAnchor, constant: -10),
            star.heightAnchor.constraint(equalToConstant: 20),
            star.widthAnchor.constraint(equalToConstant: 20)
        ]
        
        let voteLbCostraints = [
            voteLb.leadingAnchor.constraint(equalTo: star.trailingAnchor, constant: 5),
            voteLb.centerYAnchor.constraint(equalTo: star.centerYAnchor)
        ]
        
        let posterImageConstraints = [
            posterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            posterImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            posterImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            posterImage.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        //  MARK:- Activate Constraints
        NSLayoutConstraint.activate(customViewConstraints)
        NSLayoutConstraint.activate(stackViewForButtonsConstaints)
        NSLayoutConstraint.activate(firstGenreConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(starImageConstraints)
        NSLayoutConstraint.activate(removeBtnConstraints)
        NSLayoutConstraint.activate(voteLbCostraints)
        NSLayoutConstraint.activate(posterImageConstraints)
    }
}

extension WatchedFilmTableViewCell {
    
    //  MARK:- Private Functions
    private func round(number: Double) -> Double {
        var roundedNumber = number
        roundedNumber.roundingNumber(at: 1)
        return roundedNumber
    }
    
    private func set(title genre: [Genres], for button: UIButton) {
        guard let titleForButton = getGenre(by: button.tag, from: genre) else {
            button.alpha = 0
            return
        }
        button.setTitle(titleForButton, for: .normal)
        
    }
    
    private func getGenre(by index: Int, from genre: [Genres]) -> String? {
        return (index < genre.count) ? genre[index].name : nil
    }
    
    //  MARK:- Button Actions
    @objc func genreButtonTapped(button: UIButton) {
        button.backgroundColor = (button.backgroundColor == .none) ? .systemBlue : .none
        delegate?.genreInCellDidTapped(genre: filmGenre[button.tag])
    }
    
    @objc func removeMovieFromList() {
        delegate?.removeMovieFromList(by: filmId)
    }
    
}
