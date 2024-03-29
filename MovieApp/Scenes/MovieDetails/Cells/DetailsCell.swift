//
//  DetailsTableViewCell.swift
//  
//
//  Created by Admin on 9/9/22.
//

import UIKit

final class DetailsCell: UITableViewCell {
    static var identifier: String { .init(describing: self) }
    
    //  MARK:- objects
    private lazy var movieTitleLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = Constants.Design.Font.HeadingOne
        lb.textColor = Constants.Design.Color.Primary.White
        lb.adjustsFontSizeToFitWidth = true
        lb.minimumScaleFactor = 0.5
        lb.textAlignment = .left
        lb.numberOfLines = 0
        lb.text = "Star Wars: The Last Jedi"
        return lb
    }()
    
    private lazy var voteLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = Constants.Design.Font.Sub
        lb.textColor = Constants.Design.Color.Primary.White
        lb.textAlignment = .center
        lb.layer.cornerRadius = Constants.Content.Category.CornerRadius.min
        lb.layer.borderWidth = 1
        lb.layer.borderColor = UIColor(white: 1, alpha: 0.25).cgColor
        lb.text = "4K"
        return lb
    }()
    
    private lazy var timeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = Constants.Design.Image.Icon.Clock?.withTintColor(.white, renderingMode: .alwaysOriginal)
        return imageView
    }()
    
    private lazy var durationTime: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = Constants.Design.Font.Sub
        lb.textColor = Constants.Design.Color.Primary.WhiteDisable
        lb.textAlignment = .left
        lb.text = "152 minutes"
        return lb
    }()
    
    private lazy var starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = Constants.Design.Image.Icon.Star?.withTintColor(.white, renderingMode: .alwaysOriginal)
        return imageView
    }()
    
    private lazy var ratingLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = Constants.Design.Font.Sub
        lb.textColor = Constants.Design.Color.Primary.WhiteDisable
        lb.textAlignment = .left
        lb.text = "7.0 (IMDb)"
        return lb
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        backgroundColor = UIColor(white: 1, alpha: 0)
        addItemToSubView()
        adjustConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addItemToSubView() {
        contentView.addSubview(movieTitleLb)
        contentView.addSubview(voteLb)
        contentView.addSubview(timeImageView)
        contentView.addSubview(durationTime)
        contentView.addSubview(starImageView)
        contentView.addSubview(ratingLb)
    }
    
    func configure(with model: MovieViewModel) {
        self.movieTitleLb.text = model.title
        self.durationTime.text = "\(model.runTime) minutes"
        self.ratingLb.text = "\(model.rate.rounded()) (IMDb)"
        let vote = (model.vote / 1000) > 0 ? "\(model.vote / 1000)K" : "\(model.vote / 100)C"
        self.voteLb.text = vote
    }
}

extension DetailsCell {
    
    //  MARK:- Adjust Constraints
    private func adjustConstraints() {
        
        let movieTitleLbContraints = [
            movieTitleLb.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            movieTitleLb.topAnchor.constraint(equalTo: topAnchor, constant: 24)
        ]
        
        let voteLbConstraints = [
            voteLb.leadingAnchor.constraint(equalTo: movieTitleLb.trailingAnchor, constant: 15),
            voteLb.centerYAnchor.constraint(equalTo: movieTitleLb.centerYAnchor),
            voteLb.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            voteLb.heightAnchor.constraint(equalToConstant: 23),
            voteLb.widthAnchor.constraint(equalToConstant: 39)
        ]
        
        let timeImageViewConstraints = [
            timeImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 31),
            timeImageView.topAnchor.constraint(equalTo: movieTitleLb.bottomAnchor, constant: 14),
            timeImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            timeImageView.widthAnchor.constraint(equalToConstant: 12)
        ]
        
        let durationTimeConstraints = [
            durationTime.centerYAnchor.constraint(equalTo: timeImageView.centerYAnchor),
            durationTime.leadingAnchor.constraint(equalTo: timeImageView.trailingAnchor, constant: 6)
        ]
        
        let starImageViewConstraints = [
            starImageView.leadingAnchor.constraint(equalTo: durationTime.trailingAnchor, constant: 18),
            starImageView.centerYAnchor.constraint(equalTo: durationTime.centerYAnchor),
            starImageView.heightAnchor.constraint(equalToConstant: 12),
            starImageView.widthAnchor.constraint(equalTo: timeImageView.heightAnchor, multiplier: 1)
        ]
        
        let ratingLbConstraints = [
            ratingLb.centerYAnchor.constraint(equalTo: starImageView.centerYAnchor),
            ratingLb.leadingAnchor.constraint(equalTo: starImageView.trailingAnchor, constant: 6)
        ]
        
        NSLayoutConstraint.activate(movieTitleLbContraints)
        NSLayoutConstraint.activate(voteLbConstraints)
        NSLayoutConstraint.activate(timeImageViewConstraints)
        NSLayoutConstraint.activate(durationTimeConstraints)
        NSLayoutConstraint.activate(starImageViewConstraints)
        NSLayoutConstraint.activate(ratingLbConstraints)
    }
    
}
