//
//  DetailsTableViewCell.swift
//  Netflix
//
//  Created by Admin on 9/9/22.
//

import UIKit

class DetailsCell: UITableViewCell {
    static var identifier: String { .init(describing: self) }
    
    private lazy var viewForBackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = MovieDetailsVCConst.cornerRadius
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .red
        return imageView
    }()
    
    private lazy var infoLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = lb.font.withSize(Constans.fontSize)
        lb.text = "SOme Text"
        return lb
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor(white: 1, alpha: 0)
        addItemToSubView()
        adjustConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addItemToSubView() {
        contentView.addSubview(viewForBackground)
        viewForBackground.addSubview(logoImageView)
        viewForBackground.addSubview(infoLb)
    }
    
    func configure(){
        
    }
    
}

extension DetailsCell {
    
    //  MARK:- Adjust Constraints
    private func adjustConstraints() {
        let viewForBackgroundConstraints = [
            viewForBackground.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            viewForBackground.topAnchor.constraint(equalTo: topAnchor),
            viewForBackground.centerXAnchor.constraint(equalTo: centerXAnchor),
            viewForBackground.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        
        let logoImageViewConstraints = [
            logoImageView.leadingAnchor.constraint(equalTo: viewForBackground.leadingAnchor, constant: 5),
            logoImageView.centerYAnchor.constraint(equalTo: viewForBackground.centerYAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 30),
            logoImageView.widthAnchor.constraint(equalTo: logoImageView.heightAnchor, multiplier: 1)
        ]
        
        let infoLbConstraints = [
            infoLb.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 10),
            infoLb.centerYAnchor.constraint(equalTo: logoImageView.centerYAnchor),
            infoLb.trailingAnchor.constraint(equalTo: viewForBackground.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(viewForBackgroundConstraints)
        NSLayoutConstraint.activate(logoImageViewConstraints)
        NSLayoutConstraint.activate(infoLbConstraints)
    }
    
}
