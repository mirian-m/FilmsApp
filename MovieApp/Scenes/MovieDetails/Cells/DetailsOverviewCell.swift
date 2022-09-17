//
//  DetailsOverviewCell.swift
//  Netflix
//
//  Created by Admin on 9/9/22.
//

import UIKit

class DetailsOverviewCell: UITableViewCell {
    static var identifier: String { .init(describing: self) }
    
    private let startingHeight: CGFloat = 30
    
    private let buttonTitles = ["Show More", "Show Less"]
    lazy var heightConstraint = overview.heightAnchor.constraint(equalToConstant: startingHeight)
    
    private lazy var synopsisLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = Constants.Design.Font.HeadingThree
        lb.textColor = Constants.Design.Color.Primary.White
        lb.text = "Synopsis"
        return lb
    }()
    
    private lazy var overview: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = Constants.Design.Color.Background.None
        textView.font = Constants.Design.Font.Sub
        textView.textColor = Constants.Design.Color.Primary.White
        textView.isScrollEnabled = false
        textView.textContainerInset = UIEdgeInsets.zero
        textView.textContainer.lineFragmentPadding = .zero
        textView.text = "Rey (Daisy Ridley) finally manages to find the legendary Jedi knight, Luke Skywalker (Mark Hamill) on an island with a magical aura."
        return textView
    }()
    
    private lazy var buttonForMoreContext: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Show More...", for: .normal)
        button.tintColor = Constants.Design.Color.Primary.White
        button.titleLabel?.font = UIFont(descriptor: UIFontDescriptor(), size: 10)
        button.addTarget(self, action: #selector(showMoreContext), for: .touchUpInside)
        return button
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        backgroundColor = Constants.Design.Color.Background.None
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
        contentView.addSubview(synopsisLb)
        contentView.addSubview(overview)
        contentView.addSubview(buttonForMoreContext)
    }
    
    //  MARK:- Adjust Constraints
    private func adjustConstraints() {
        
        let synopsisLbConstraints = [
            synopsisLb.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            synopsisLb.topAnchor.constraint(equalTo: topAnchor, constant: 16)
        ]
        
        let overviewConstraints = [
            overview.leadingAnchor.constraint(equalTo: synopsisLb.leadingAnchor),
            overview.centerXAnchor.constraint(equalTo: centerXAnchor),
            overview.topAnchor.constraint(equalTo: synopsisLb.bottomAnchor, constant: 5),
        ]
        
        let buttonForMoreContextConstraints = [
            buttonForMoreContext.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonForMoreContext.topAnchor.constraint(equalTo: overview.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(synopsisLbConstraints)
        NSLayoutConstraint.activate(overviewConstraints)
        NSLayoutConstraint.activate(buttonForMoreContextConstraints)
    }
    
    //  MARK:- Button Action, Shows Or hide content of textView
    @objc func showMoreContext(_ sender: UIButton) {
        heightConstraint.constant = overview.getTextViewHeightAccordingToHisContent()
        heightConstraint.isActive = true
        sender.isHidden = true
    }
}

extension UITextView {
    
    //  MARK:- Get TextView height size according to his content
    fileprivate func getTextViewHeightAccordingToHisContent() -> CGFloat {
        let textView : UITextView = UITextView(frame: CGRect(x: self.frame.origin.x, y: 0, width: self.frame.size.width, height: 0))
        
        textView.text = self.text
        textView.sizeToFit()
        
        var txtFrame : CGRect = CGRect()
        txtFrame = textView.frame
        
        var size : CGSize = CGSize()
        size = txtFrame.size
        
        size.height = txtFrame.size.height
        
        return size.height > 150 ? 150 : size.height
    }
}
