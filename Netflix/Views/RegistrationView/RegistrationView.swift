//  RegistrationView.swift
//  Netflix
//  Created by Admin on 7/30/22.

import UIKit

class RegistrationView: UIView {
    
    lazy var logo: UIImageView = {
        let logo = UIImageView()
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.image = UIImage(named: "NetflixLogo")
        logo.contentMode = .scaleAspectFill
        logo.clipsToBounds = true
        addSubview(logo)
        return logo
    }()
    
    lazy var segmentControl: UISegmentedControl = {
        let segments = ["Sign In", "Register"]
        let segment = UISegmentedControl(items: segments)
        segment.translatesAutoresizingMaskIntoConstraints = false
        addSubview(segment)
        return segment
    }()
    
    lazy var conteinerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .none
        addSubview(view)
        return view
    }()
    
    lazy var regitrationStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 15
        conteinerView.addSubview(stack)
        return stack
    }()
    
    lazy var firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "First Name"
        textField.backgroundColor = .systemGray6
        textField.font = UIFont(name: "Helvetica Neue", size: 15)
        textField.textColor = UIColor.customColor
        textField.layer.cornerRadius = 5
        textField.setLeftPaddingPoints(10)
        return textField
    }()
    
    lazy var lastNameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Last name"
        textField.backgroundColor = .systemGray6
        textField.font = UIFont(name: "Helvetica Neue", size: 15)
        textField.textColor = UIColor.customColor
        textField.layer.cornerRadius = 5
        textField.setLeftPaddingPoints(10)
        return textField
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Email"
        textField.backgroundColor = .systemGray6
        textField.font = UIFont(name: "Helvetica Neue", size: 15)
        textField.textColor = UIColor.customColor
        textField.layer.cornerRadius = 5
        textField.setLeftPaddingPoints(10)
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Password"
        textField.backgroundColor = .white
        textField.font = UIFont(name: "Helvetica Neue", size: 15)
        textField.backgroundColor = .systemGray6
        textField.textColor = UIColor.customColor
        textField.layer.cornerRadius = 5
        textField.setLeftPaddingPoints(10)
        return textField
    }()
    
    lazy var confirmPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Confirm Password"
        textField.backgroundColor = .white
        textField.font = UIFont(name: "Helvetica Neue", size: 15)
        textField.backgroundColor = .systemGray6
        textField.textColor = UIColor.customColor
        textField.layer.cornerRadius = 5
        textField.setLeftPaddingPoints(10)
        return textField
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.backgroundColor = UIColor(red: 0.824, green: 0.184, blue: 0.149, alpha: 1).cgColor
        button.tintColor = .white
        button.layer.cornerRadius = 5
        addSubview(button)
        return button
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        indicator.color = .blue
        button.addSubview(indicator)
        return indicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        self.backgroundColor = UIColor(white: 1, alpha: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super .layoutSubviews()
        embedItemsInStackView()
        adjustConstraints()
    }
}

extension RegistrationView {
    private func embedItemsInStackView() {
        regitrationStackView.addArrangedSubview(firstNameTextField)
        regitrationStackView.addArrangedSubview(lastNameTextField)
        regitrationStackView.addArrangedSubview(emailTextField)
        regitrationStackView.addArrangedSubview(passwordTextField)
        regitrationStackView.addArrangedSubview(confirmPasswordTextField)
    }
    
    private func adjustConstraints() {
        let logoConstraints = [
            logo.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logo.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 50),
            logo.heightAnchor.constraint(equalToConstant: 22),
            logo.widthAnchor.constraint(equalToConstant: 83)
        ]
        
        let segmentConstraints = [
            segmentControl.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            segmentControl.leadingAnchor.constraint(equalTo: regitrationStackView.leadingAnchor),
            segmentControl.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 40),
            segmentControl.heightAnchor.constraint(equalToConstant: 35)
        ]
        
        let viewConteinerConstraints = [
            conteinerView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor),
            conteinerView.bottomAnchor.constraint(equalTo: button.topAnchor),
            conteinerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            conteinerView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16)
        ]
        
        let stackViewConstraints = [
            regitrationStackView.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor),
            regitrationStackView.centerXAnchor.constraint(equalTo: conteinerView.centerXAnchor),
            regitrationStackView.centerYAnchor.constraint(equalTo: conteinerView.centerYAnchor)
        ]
        
        let passwordTextFieldConstraints = [
            passwordTextField.heightAnchor.constraint(equalToConstant: 48)
        ]
        
        let buttonConstraints = [
            button.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            button.leadingAnchor.constraint(equalTo: regitrationStackView.leadingAnchor),
            button.topAnchor.constraint(equalTo: regitrationStackView.bottomAnchor, constant: 48),
            button.heightAnchor.constraint(equalToConstant: 48)
        ]
        
        let activiteIndicatorConstraints = [
            activityIndicator.centerXAnchor.constraint(equalTo: self.button.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.button.centerYAnchor)
        ]
        NSLayoutConstraint.activate(logoConstraints)
        NSLayoutConstraint.activate(viewConteinerConstraints)
        NSLayoutConstraint.activate(stackViewConstraints)
        NSLayoutConstraint.activate(segmentConstraints)
        NSLayoutConstraint.activate(passwordTextFieldConstraints)
        NSLayoutConstraint.activate(buttonConstraints)
        NSLayoutConstraint.activate(activiteIndicatorConstraints)
    }
    
}
