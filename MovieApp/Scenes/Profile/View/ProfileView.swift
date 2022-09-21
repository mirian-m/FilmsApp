//
//  ProfileView.swift
//  Netflix
//
//  Created by Admin on 9/16/22.
//

import UIKit

final class ProfileView: UIView {
    
    private lazy var cancelBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        let configImage = UIImage.SymbolConfiguration(pointSize: 20, weight: .thin, scale: .large)
        let image = UIImage(systemName:"multiply",
                            withConfiguration: configImage)?.withTintColor(Constants.Design.Color.Primary.White, renderingMode: .alwaysOriginal)
        
        btn.setImage(image, for: .normal)
        btn.addTarget(self, action: #selector(cancelBtnTapped), for: .touchUpInside)
        self.addSubview(btn)
        return btn
    }()
    
    private lazy var profileImg: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = Constants.Design.Image.DefaultProfileImage?.withTintColor(.white, renderingMode: .alwaysOriginal)
        addSubview(imageView)
        return imageView
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.addArrangedSubview(firstNameLb)
        stack.addArrangedSubview(lastNameLb)
        stack.addArrangedSubview(emailLb)
        stack.spacing = 0
        stack.alignment = .leading
        addSubview(stack)
        return stack
    }()
    
    private lazy var firstNameLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.setDesign()
        return lb
    }()
    
    private lazy var lastNameLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.setDesign()
        return lb
    }()
    
    private lazy var emailLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.setDesign()
        return lb
    }()
    
    private lazy var signOut: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Sign Out", for: .normal)
        btn.backgroundColor = .red
        btn.layer.cornerRadius = Constants.Content.Category.CornerRadius.middle
        btn.addTarget(self, action: #selector(signOutBtnTapped), for: .touchUpInside)
        addSubview(btn)
        return btn
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        indicator.color = .blue
        indicator.hidesWhenStopped = true
        profileImg.addSubview(indicator)
        return indicator
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageDidTapped))
        profileImg.addGestureRecognizer(tapGesture)
        self.backgroundColor = Constants.Design.Color.Background.Light
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        adjustConstraints()
        setButtonsIcon()
        profileImg.layer.cornerRadius = profileImg.frame.height / 2
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure(with model: ProfileViewModel) {
        activityIndicator.startAnimating()
        self.firstNameLb.text = "Name: " + model.name
        self.lastNameLb.text = "Surname: " + model.surName
        self.emailLb.text = "Email: " + model.email
        NetworkService.shared.getImageFromWeb(by: model.profileImageUrl) { [weak self] (image, _) in
            self?.profileImg.image = image
            self?.activityIndicator.stopAnimating()
        }
    }
    
    func changeProfileImage(image: UIImage) {
        self.profileImg.image = image
        
    }
    //  MARK:- Button Action
    @objc private func signOutBtnTapped() {
        NotificationCenter.default.post(name: .signOutButtonDidTapped, object: nil)
    }
    @objc private func cancelBtnTapped() {
        NotificationCenter.default.post(name: .cancelButtonDidTapped, object: nil)
    }
    
    @objc private func imageDidTapped() {
        NotificationCenter.default.post(name: .imageDidTapped, object: nil)
        
    }
    //  MARK:- Private Methods
    private func setButtonsIcon() {
        signOut.setButton(image: (Constants.Design.Image.Icon.SigOut?.withTintColor(.white, renderingMode: .alwaysOriginal))!, horizontalAligment: .center)
    }
    
    private func adjustConstraints() {
        let cancelBtnConstraints = [
            cancelBtn.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            cancelBtn.topAnchor.constraint(equalTo: self.topAnchor, constant: 20)
        ]
        
        let profileImgConstraints = [
            profileImg.heightAnchor.constraint(equalToConstant: 100),
            profileImg.widthAnchor.constraint(equalTo: profileImg.heightAnchor),
            profileImg.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            profileImg.topAnchor.constraint(equalTo: self.topAnchor, constant: 30)
        ]
        
        let stackViewConstraints = [
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.topAnchor.constraint(equalTo: profileImg.bottomAnchor, constant: 20)
        ]
        
        let signOutConstraints = [
            signOut.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            signOut.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            signOut.centerXAnchor.constraint(equalTo: centerXAnchor),
            signOut.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: 20),
            signOut.heightAnchor.constraint(equalToConstant: 50)
        ]
        let activityIndicatorConstraints = [
            activityIndicator.centerXAnchor.constraint(equalTo: profileImg.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: profileImg.centerYAnchor)
        ]
        
        //  MARK:- Activate contraints
        NSLayoutConstraint.activate(cancelBtnConstraints)
        NSLayoutConstraint.activate(profileImgConstraints)
        NSLayoutConstraint.activate(stackViewConstraints)
        NSLayoutConstraint.activate(signOutConstraints)
        NSLayoutConstraint.activate(activityIndicatorConstraints)
    }
}

extension UILabel {
    fileprivate func setDesign() {
        self.font = UIFont(name: "Inter-Bold", size: 16)
        self.textColor = Constants.Design.Color.Primary.White
        self.text = "Mirian Maglakelidze"
    }
}

extension UIButton {
    
    //  MARK:- Set Image To Button With distans
   fileprivate func setButton(image: UIImage, horizontalAligment: ContentHorizontalAlignment) {
        self.setImage(image, for: .normal)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
        self.contentHorizontalAlignment = horizontalAligment
        self.imageView?.contentMode = .scaleAspectFit
    }
}
