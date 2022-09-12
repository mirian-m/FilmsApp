//
//  MoreDetailsTableViewCell.swift
//  Netflix
//
//  Created by Admin on 9/11/22.
//

import UIKit

class MoreDetailsTableViewCell: UITableViewCell {
    static var identifier: String { .init(describing: self) }
    
    weak var delegate: WatchedFilmTableViewCellDelegate?
    private var genreButtons: [UIButton] = []
    
    private lazy var releaseDateTitleLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "Lato-Medium", size: 16)
        lb.textColor = .white
        lb.textAlignment = .left
        lb.text = "Release date"
        return lb
    }()
    
    private lazy var genreLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "Lato-Medium", size: 16)
        lb.textColor = .white
        lb.textAlignment = .left
        lb.text = "Genre"
        return lb
    }()
    
    private lazy var dateLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "Lato-Regular", size: 12)
        lb.textColor = UIColor(red: 0.74, green: 0.74, blue: 0.74, alpha: 1)
        lb.textAlignment = .left
        lb.text = "December 9, 2017"
        return lb
    }()
    
    private lazy var stackViewForButtons: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 10
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
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
        contentView.addSubview(releaseDateTitleLb)
        contentView.addSubview(stackViewForButtons)
        contentView.addSubview(genreLb)
        contentView.addSubview(dateLb)
    }
    
    func configure(with model: MovieViewModel) {
        self.dateLb.text = model.releaseDate
        if !model.genres.isEmpty {
            genreButtons.forEach { button in
                set(title: model.genres, for: button)
            }
        }
    }
}

extension MoreDetailsTableViewCell {
    
    //  MARK:- Set genre button Title
    private func set(title genre: [Genres], for button: UIButton) {
        guard let titleForButton = getGenre(by: button.tag, from: genre) else {
            button.alpha = 0
            return
        }
        button.setTitle(titleForButton, for: .normal)
    }
    
    //  MARK:- Get Title for Button from Genre
    private func getGenre(by index: Int, from genre: [Genres]) -> String? {
        return (index < genre.count) ? genre[index].name == "Science Fiction" ? "Sci-Fi" : genre[index].name : nil
    }
    
    //  MARK:- Adjust Constraints
    private func adjustConstraints() {
        
        let releaseDataLbContraints = [
            releaseDateTitleLb.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            releaseDateTitleLb.topAnchor.constraint(equalTo: topAnchor, constant: 24)
        ]
        
        let genreLbConstraints = [
            genreLb.centerYAnchor.constraint(equalTo: releaseDateTitleLb.centerYAnchor),
            genreLb.leadingAnchor.constraint(equalTo: releaseDateTitleLb.trailingAnchor, constant: 56)
        ]
        let stackViewForButtonsConstraints = [
            stackViewForButtons.centerYAnchor.constraint(equalTo: dateLb.centerYAnchor),
            stackViewForButtons.leadingAnchor.constraint(equalTo: genreLb.leadingAnchor)
        ]
        
        let dateLbConstraints = [
            dateLb.leadingAnchor.constraint(equalTo: releaseDateTitleLb.leadingAnchor),
            dateLb.topAnchor.constraint(equalTo: releaseDateTitleLb.bottomAnchor, constant: 12)
        ]
        
        let firstGenreConstraints = [
            firstGenre.widthAnchor.constraint(equalToConstant: 55),
            firstGenre.heightAnchor.constraint(equalToConstant: 17)
        ]
        
        NSLayoutConstraint.activate(releaseDataLbContraints)
        NSLayoutConstraint.activate(genreLbConstraints)
        NSLayoutConstraint.activate(stackViewForButtonsConstraints)
        NSLayoutConstraint.activate(dateLbConstraints)
        NSLayoutConstraint.activate(firstGenreConstraints)
    }
}

extension UIButton {
    
    //  MARK:- Set design for button
    func setDesign() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.tintColor = UIColor.white
        self.titleLabel?.font = UIFont(descriptor: UIFontDescriptor(), size: 12)
        self.setTitle("Action", for: .normal)
    }
}
