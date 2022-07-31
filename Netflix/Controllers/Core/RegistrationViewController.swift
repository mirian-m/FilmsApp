//  RegistrationViewController.swift
//  Netflix
//  Created by Admin on 7/30/22.
import UIKit

protocol RegistrationViewControllerDelegate {
    func checkEmailValidation(_ email: String) -> Bool
    func checkPasswordValidation(_ password: String) -> Bool
    func confirmPassword(_ confirmedPassword: String, _ password: String) -> Bool
    //    func registrait(user: UserData)
}

class RegistrationViewController: BackgroundImageViewControlller {
    static let identifier = "RegistrationViewController"
    
    lazy var registrationView = RegistrationView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
    
    var tag: Int!
    
    private let numberString: [String] = (0...9).map { String($0) }
    private let alphabet = [
        "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
//        navigationController?.navigationBar.isHidden = true
    }
    
    func setupViewController() {
        navigationItem.backBarButtonItem?.tintColor = .white
        navigationController?.navigationBar.isHidden = false
        self.view.addSubview(registrationView)
        registrationView.segmentControl.selectedSegmentIndex = tag
        let title = registrationView.segmentControl.titleForSegment(at: tag)
        registrationView.button.setTitle(title, for: .normal)
        setup(registrationView.segmentControl)
        addTargets()
    }
    
    func addTargets() {
        registrationView.segmentControl.addTarget(self, action: #selector(setup(_:)), for: .allEvents)
        registrationView.button.addTarget(self, action: #selector(registrait), for: .touchUpInside)
    }
    
    @objc func registrait(_ sender: UIButton) {
         let tbVc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarController")
        navigationController?.pushViewController(tbVc, animated: true)
    }
    
    @objc func setup(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            registrationView.emailTextField.isHidden = true
            registrationView.confirmPasswordTextField.isHidden = true
        case 1:
            registrationView.emailTextField.isHidden = false
            registrationView.confirmPasswordTextField.isHidden = false
        default:
            return
        }
        let title = registrationView.segmentControl.titleForSegment(at: registrationView.segmentControl.selectedSegmentIndex)
        registrationView.button.setTitle(title, for: .normal)
        
        if tag != nil {
            self.view.addSubview(registrationView)
            tag = nil
        } else {
            addSubviewWithAnimation()
        }
    }
    
    func addSubviewWithAnimation() {
        UIView.animate(withDuration: 1.5) {
            self.registrationView.regitrationStackView.center.x = -self.view.frame.width
            self.registrationView.button.alpha = 0
        } completion: { done in
            if done {
                UIView.animate(withDuration: 1.5) { [weak self] in
                    self?.view.addSubview(self!.registrationView)
                    self?.registrationView.button.alpha = 1
                }
            }
        }
    }
}

extension RegistrationViewController: RegistrationViewControllerDelegate {
    //    func registrait(user: UserData) {
    //        switch false {
    //        case checkEmailValidation(user.email):
    //            print("ada")
    ////            showAlertWith(title: "ERROR", text: "Email is not Valid")
    //        case checkEmailValidation(user.password):
    //            print("ada")
    ////            showAlertWith(title: "ERROR", text: "This password is not Secure")
    //        case confirmPassword(user.password, registrationView.confirmPasswordTextField.text ?? ""):
    //            print("ada")
    ////            showAlertWith(title: "ERROR", text: "Passwords doesn't Match")
    //        case !name.isEmpty:
    ////            showAlertWith(title: "ERROR", text: "Please fill in all Fields")
    //        default:
    ////            showSuccessMessageAndGoBackToLogIn()
    //        }
    //    }
    
    
    func confirmPassword(_ confirmedPassword: String, _ password: String) -> Bool {
        return confirmedPassword == password
    }
    
    func checkEmailValidation(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func checkPasswordValidation(_ password: String) -> Bool {
        return password.count >= 8 &&
            password.map({ alphabet.contains(String($0)) }).contains(true) &&
            password.map({ numberString.contains(String($0)) }).contains(true)
    }
    
    //    func registrationCheckFor(email: String, password: String, name: String, confirmPas: String) {
    
}
