//
//  WatchedFilmTableViewCell.swift
//  Netflix
//
//  Created by Admin on 9/7/22.
//

import UIKit

class WatchedFilmTableViewCell: UITableViewCell {
    static var identifier = "WatchedFilmTableViewCell"
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
        title.font = title.font.withSize(13)
        return title
    }()
    
    private lazy var removeBtn: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "xmark.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .red
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor(white: 1, alpha: 0)
        addItemsToView()
        applyConstreints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addItemsToView() {
        customView.addSubview(titleLabel)
        customView.addSubview(removeBtn)
        customView.addSubview(star)
        customView.addSubview(voteLb)
        contentView.addSubview(customView)
        contentView.addSubview(posterImage)
    }
    
    func applyConstreints() {
        
        let customViewConstraints = [
            customView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            customView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            customView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            customView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
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
        
        NSLayoutConstraint.activate(customViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(starImageConstraints)
        NSLayoutConstraint.activate(removeBtnConstraints)
        NSLayoutConstraint.activate(voteLbCostraints)
        NSLayoutConstraint.activate(posterImageConstraints)
    }
    
    func configure(with model: WatchedListViewModel) {
        let url = APIConstants.posterBaseURL + model.imageUrl
        posterImage.getImageFromWeb(by: url)
        titleLabel.text = model.title
        var vote = model.rate
        vote.roundingNumber(at: 1)
        voteLb.text = "\(vote)/10"
    }
}
