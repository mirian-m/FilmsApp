//  PopUpViewController.swift
//  Netflix
//
//  Created by Admin on 7/26/22.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

protocol ProfileViewControllerDelegate: AnyObject {
    func backToRootViewController()
}


class ProfileViewController: BackgroundImageViewControlller, ConfirmedViewControllerDelegate {
    func signOutFromProfile() {
        dismiss(animated: true) { [weak self] in
            self?.delegate?.backToRootViewController()
        }
    }
    
    static let identifier = "ProfileViewController"
    
    //    var isAuthorized: Bool? = true
    weak var delegate: ProfileViewControllerDelegate?
    
    //    private lazy var profileBackground: UIImageView = {
    //        let backgroundImage = UIImageView()
    //        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
    //        let layer = CAGradientLayer()
    //        layer.frame = self.view.bounds
    //        layer.colors = [UIColor.blue.cgColor, UIColor.purple.cgColor]
    //        backgroundImage.layer.addSublayer(layer)
    //        self.view.addSubview(backgroundImage)
    //        return backgroundImage
    //    }()
    
    private lazy var cancelBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        let configImage = UIImage.SymbolConfiguration(pointSize: 20,
                                                      weight: .thin,
                                                      scale: .large)
        let image = UIImage(systemName:"multiply",
                            withConfiguration: configImage)?
            .withTintColor(.white, renderingMode: .alwaysOriginal)
        btn.setImage(image, for: .normal)
        btn.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        self.view.addSubview(btn)
        return btn
    }()
    
    private lazy var profileImg: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .red
        self.view.addSubview(imageView)
        return imageView
    }()
    
    private lazy var nameLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "Inter-Bold", size: 16)
        lb.textColor = .white
        lb.text = "Mirian Maglakelidze"
        self.view.addSubview(lb)
        return lb
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.addArrangedSubview(profileBtn)
//        stack.addArrangedSubview(favouriteFilmsBtn)
        stack.addArrangedSubview(settingBtn)
        stack.addArrangedSubview(signOut)
        stack.spacing = 0
        stack.alignment = .leading
        return stack
        
    }()
    
    private lazy var profileBtn: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.setTitle("Profile", for: .normal)
        return btn
    }()
    
//    private lazy var favouriteFilmsBtn: UIButton = {
//        let btn = UIButton()
//        btn.setTitle("Favourite Films List", for: .normal)
//        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
//        return btn
//    }()
    
    private lazy var settingBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Settings", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return btn
    }()
    
    private lazy var signOut: UIButton = {
        let btn = UIButton()
        btn.setTitle("Sign Out", for: .normal)
        btn.addTarget(self, action: #selector(signOutBtnAction), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllerLayout()
        guard let userId = Auth.auth().currentUser?.uid else { return }
        UserManger.shared.getUserData(by: userId) { userData in
            self.nameLb.text = "\(userData.firstName) \(userData.lastName)"
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileImg.layer.cornerRadius = profileImg.frame.height / 2
    }
    
    func setupViewControllerLayout() {
        view.addSubview(stackView)
        adjustConstraints()
        setButtonsIcon()
    }
    
    // MARK:- Cancel Button Action
    
    @objc private func cancelAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func signOutBtnAction() {
        let confirmed = ConfirmedViewController()
        confirmed.delegate = self
        present(confirmed, animated: true, completion: nil)
    }
    
    func setButtonsIcon() {
        profileBtn.setButton(image: getConfigImage("person.fill"))
//        favouriteFilmsBtn.setButton(image: getConfigImage("star.fill"))
        settingBtn.setButton(image: getConfigImage("gearshape.fill"))
        signOut.setButton(image: getConfigImage("arrowshape.turn.up.right"))
    }
    
    func getConfigImage(_ imageName: String) -> UIImage {
        let largConfig = UIImage.SymbolConfiguration(pointSize: 20,
                                                     weight: .bold,
                                                     scale: .large)
        let image = UIImage(systemName: imageName, withConfiguration: largConfig)?.withTintColor(.white, renderingMode: .alwaysOriginal)
        return image!
    }
    
    //  MARK: Constraints
    func adjustConstraints() {
        
        let cancelBtnConstraints = [
            cancelBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 12),
            cancelBtn.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 21)
        ]
        
        let profileImgConstraints = [
            profileImg.heightAnchor.constraint(equalToConstant: 129),
            profileImg.widthAnchor.constraint(equalTo: profileImg.heightAnchor, multiplier: 1),
            profileImg.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            profileImg.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 63)
        ]
        
        let nameLbConstraints = [
            nameLb.leadingAnchor.constraint(equalTo: profileImg.leadingAnchor),
            nameLb.topAnchor.constraint(equalTo: profileImg.bottomAnchor, constant: 14)
            
        ]
        
        let stackViewConstraints = [
            stackView.topAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -100),
            stackView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -215)
        ]
        
        let profileConstraints = [
            profileBtn.widthAnchor.constraint(equalTo: stackView.widthAnchor)
        ]
        
//        let favouriteFilmsConstraints = [
//            favouriteFilmsBtn.widthAnchor.constraint(equalTo: stackView.widthAnchor)
//        ]
        
        let settingBtnConstraints = [
            settingBtn.widthAnchor.constraint(equalTo: stackView.widthAnchor)
        ]
        
        let signOutConstraints = [
            signOut.widthAnchor.constraint(equalTo: stackView.widthAnchor)
        ]
        
        //  MARK:- Activate contraints
        
        NSLayoutConstraint.activate(cancelBtnConstraints)
        NSLayoutConstraint.activate(profileImgConstraints)
        NSLayoutConstraint.activate(nameLbConstraints)
        NSLayoutConstraint.activate(stackViewConstraints)
//        NSLayoutConstraint.activate(favouriteFilmsConstraints)
        NSLayoutConstraint.activate(profileConstraints)
        NSLayoutConstraint.activate(settingBtnConstraints)
        NSLayoutConstraint.activate(signOutConstraints)
        
    }
}
