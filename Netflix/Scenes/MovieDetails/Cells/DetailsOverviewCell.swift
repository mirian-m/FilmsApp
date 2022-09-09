//
//  DetailsOverviewCell.swift
//  Netflix
//
//  Created by Admin on 9/9/22.
//

import UIKit

class DetailsOverviewCell: UITableViewCell {
    static var identifier: String { .init(describing: self) }
    private let startingHeight: CGFloat = 60
    
    private let buttonImageName = ["chevron.compact.down", "chevron.compact.up"]
    lazy var heightConstraint = viewForBackground.heightAnchor.constraint(equalToConstant: startingHeight)
    
    private lazy var viewForBackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = MovieDetailsVCConst.cornerRadius
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var overview: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.cornerRadius = MovieDetailsVCConst.cornerRadius
        return textView
    }()
    
    private lazy var buttonForMoreContext: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("BUtton", for: .normal)
        button.tag = 0
        button.setImage(getImage(by: buttonImageName[button.tag]), for: .normal)
        button.addTarget(self, action: #selector(show), for: .touchUpInside)
        return button
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
        heightConstraint.isActive = true
        addItemToSubView()
        adjustConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configur(with model: MovieViewModel) {
        self.overview.text = model.overview
    }
}

extension DetailsOverviewCell {
    
    private func addItemToSubView() {
        contentView.addSubview(viewForBackground)
        viewForBackground.addSubview(overview)
        viewForBackground.addSubview(buttonForMoreContext)
    }
    
    //  MARK:- Adjust Constraints
    private func adjustConstraints() {
        let viewForBackgroundConstraints = [
            viewForBackground.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            viewForBackground.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            viewForBackground.centerXAnchor.constraint(equalTo: centerXAnchor)
        ]
        
        let overviewConstraints = [
            overview.leadingAnchor.constraint(equalTo: viewForBackground.leadingAnchor, constant: 5),
            overview.heightAnchor.constraint(equalTo: viewForBackground.heightAnchor, multiplier: 1),
            overview.trailingAnchor.constraint(equalTo: buttonForMoreContext.leadingAnchor, constant: -5),
        ]
        
        let buttonForMoreContextConstraints = [
            buttonForMoreContext.trailingAnchor.constraint(equalTo: viewForBackground.trailingAnchor, constant: -5),
            buttonForMoreContext.centerYAnchor.constraint(equalTo: viewForBackground.centerYAnchor),
            buttonForMoreContext.widthAnchor.constraint(equalToConstant: 30),
            buttonForMoreContext.heightAnchor.constraint(equalTo: buttonForMoreContext.widthAnchor, multiplier: 1)
        ]
        
        NSLayoutConstraint.activate(viewForBackgroundConstraints)
        NSLayoutConstraint.activate(overviewConstraints)
        NSLayoutConstraint.activate(buttonForMoreContextConstraints)
    }
    
    //  MARK:- Button Action, Shows Or hide content of textView
    @objc func show() {
        switch buttonForMoreContext.tag {
        case 0:
            heightConstraint.constant = overview.getTextViewHeightAccordingToHisContent()
            heightConstraint.isActive = true
            buttonForMoreContext.tag = 1
        case 1:
            buttonForMoreContext.tag = 0
            heightConstraint.constant = startingHeight
            heightConstraint.isActive = true
        default:
            break
        }
        buttonForMoreContext.setImage(getImage(by: buttonImageName[buttonForMoreContext.tag]), for: .normal)
    }
    
    private func getImage(by systemName: String) -> UIImage {
        guard let buttonImage = UIImage(
                systemName: systemName,
                withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))?
                .withRenderingMode(.alwaysOriginal)
                .withTintColor(UIColor.black) else { return UIImage()
            
        }
        return buttonImage
    }
}

extension UITextView {
    
    //  MARK:- Get TextView height size according to his content
    func getTextViewHeightAccordingToHisContent() -> CGFloat {
        let textView : UITextView = UITextView(
            frame: CGRect(x: self.frame.origin.x,
                          y: 0, width: self.frame.size.width,
                          height: 0))
        textView.text = self.text
        textView.sizeToFit()
        
        var txtFrame : CGRect = CGRect()
        txtFrame = textView.frame
        
        var size : CGSize = CGSize()
        size = txtFrame.size
        
        size.height = txtFrame.size.height
        
        return size.height
    }
    
    
}
