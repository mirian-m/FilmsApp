//  RegistrationView.swift
//  Netflix
//  Created by Admin on 7/30/22.

import UIKit

final class RegistrationView: UIView {
    
    //  MARK: @IBOutlet programmatically
    private lazy var logo: UIImageView = {
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
        view.backgroundColor = Constants.Design.Color.Background.None
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
        textField.setDesign()
        textField.placeholder = "First Name"
        return textField
    }()
    
    lazy var lastNameTextField: UITextField = {
        let textField = UITextField()
        textField.setDesign()
        textField.placeholder = "Last name"
        return textField
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.setDesign()
        textField.placeholder = "Email"
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.setDesign()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.enablePasswordToggle()
        return textField
    }()
    
    lazy var confirmPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.setDesign()
        textField.placeholder = "Confirm Password"
        textField.isSecureTextEntry = true
        textField.enablePasswordToggle()
        return textField
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.backgroundColor = UIColor(red: 0.824, green: 0.184, blue: 0.149, alpha: 1).cgColor
        button.tintColor = Constants.Design.Color.Primary.White
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
    
    //  MARK-: Object lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        self.backgroundColor = Constants.Design.Color.Background.None
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  MARK: View lifecycle
    override func layoutSubviews() {
        super .layoutSubviews()
        embedItemsInStackView()
        adjustConstraints()
    }
}

extension RegistrationView {
    
    //  MARK:- Private Metods
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

extension UITextField {
    fileprivate func setDesign(){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.attributedPlaceholder = NSAttributedString(string: "Place Holder",
                                                        attributes: [NSAttributedString.Key.foregroundColor: Constants.Design.Color.Primary.White])
        self.backgroundColor = UIColor(white: 1, alpha: 0)
        self.font = Constants.Design.Font.Body
        self.textColor = Constants.Design.Color.Primary.White
        self.layer.cornerRadius = 5
        self.setLeftPaddingPoints(10)
    }
}
extension UITextField {
    
    //  MARK:- Textfield Show and hide content logic, while presed button
    fileprivate func setPasswordToggleImage(_ button: UIButton) {
        if isSecureTextEntry {
            button.setImage(Constants.Design.Image.IconEyeSlash?.withTintColor(Constants.Design.Color.Primary.WhiteDisable, renderingMode: .alwaysOriginal), for: .normal)
        } else {
            button.setImage(Constants.Design.Image.IconEye?.withTintColor(Constants.Design.Color.Primary.WhiteDisable, renderingMode: .alwaysOriginal), for: .normal)
        }
    }
    
    fileprivate func enablePasswordToggle(){
        let button = UIButton(type: .custom)
        setPasswordToggleImage(button)
        button.addTarget(self, action: #selector(self.togglePasswordView), for: .touchUpInside)
        self.rightView = button
        self.rightViewMode = .always
    }
    
    @objc fileprivate func togglePasswordView(_ sender: UIButton) {
        self.isSecureTextEntry.toggle()
        setPasswordToggleImage(sender)
    }
}
