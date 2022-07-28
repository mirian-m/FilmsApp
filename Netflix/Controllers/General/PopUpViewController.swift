//  PopUpViewController.swift
//  Netflix
//
//  Created by Admin on 7/26/22.
//

import UIKit

class PopUpViewController: UIViewController {
    static let identifier = "PopUpViewController"
    
    private lazy var profileBackground: UIImageView = {
        let background = UIImageView()
        background.translatesAutoresizingMaskIntoConstraints = false
        let layer = CAGradientLayer()
        layer.frame = self.view.bounds
        layer.colors = [UIColor.blue.cgColor, UIColor.purple.cgColor]
        background.layer.addSublayer(layer)
        self.view.addSubview(background)
        return background
    }()
    
    private lazy var cancelBtn: UIButton = {
        let btn = UIButton()
        let largConfig = UIImage.SymbolConfiguration(pointSize: 20,
                                                     weight: .thin,
                                                     scale: .large)
        let image = UIImage(systemName:"multiply",
                            withConfiguration: largConfig)?
            .withRenderingMode(.alwaysOriginal).withTintColor(.white)
        btn.setImage(image, for: .normal)
        btn.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(btn)
        return btn
    }()
    
    private lazy var profileImg: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(imageView)
        return imageView
    }()
    
    private lazy var nameLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "Inter-Bold", size: 16)
        lb.text = "Mirian Maglakelidze"
        self.view.addSubview(lb)
       return lb
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(signIn)
        stack.addArrangedSubview(favouriteFilms)
        stack.addArrangedSubview(seenFilms)
        stack.addArrangedSubview(signOut)
        return stack
        
    }()
    
    private lazy var signIn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Sign In", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var favouriteFilms: UIButton = {
        let btn = UIButton()
        btn.setTitle("Favourite", for: .normal)
        return btn
        
    }()
    
    private lazy var seenFilms: UIButton = {
        let btn = UIButton()
        btn.setTitle("Seen", for: .normal)
        return btn
        
    }()
    
    private lazy var signOut: UIButton = {
        let btn = UIButton()
        btn.setTitle("Sign Out", for: .normal)
        return btn
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        profileBackground.frame = self.view.bounds
        view.addSubview(stackView)
        adjustConstraints()
        //        self.view.translatesAutoresizingMaskIntoConstraints = false
        //        topLevelView.backgroundColor = .red
        //        let fittingSize = self.view.sizeThatFits(UIView.layoutFittingCompressedSize)
        //        self.view.frame.size = CGSize(width: fittingSize.width, height: fittingSize.height)
        //                view.addSubview(stackView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileImg.layer.cornerRadius = profileImg.frame.height / 2
    }
    
    func adjustConstraints() {
//        let profileBackgroundConstraints = [
//            profileBackground
//        ]
        
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
            stackView.topAnchor.constraint(equalTo: profileImg.bottomAnchor, constant: 156.4),
            stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        ]
        
        let signUpConstraints = [
            signIn.heightAnchor.constraint(equalToConstant: 30),
            signIn.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        NSLayoutConstraint.activate(cancelBtnConstraints)
        NSLayoutConstraint.activate(profileImgConstraints)
        NSLayoutConstraint.activate(nameLbConstraints)
        NSLayoutConstraint.activate(stackViewConstraints)
        NSLayoutConstraint.activate(signUpConstraints)
        
    }
    
    @objc private func cancelAction() {
        self.dismiss(animated: true, completion: nil)
    }
}
