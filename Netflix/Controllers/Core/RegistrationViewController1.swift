//  RegistrationViewController.swift
//  Netflix
//  Created by Admin on 7/30/22.

import UIKit
import FirebaseAuth
import Firebase


protocol RegistrationChecker {
    func checkEmailValidation(_ email: String) -> Bool
    func checkPasswordValidation(_ password: String) -> Bool
    func confirmPassword(_ confirmedPassword: String, _ password: String) -> Bool
    func showAlertWith(title: String, text: String)
    func checkAllFields(_ user: UserData)
    func saveUserData(_ userData: UserData)
}

class RegistrationViewController1: BackgroundImageViewControlller {
    static let identifier = "RegistrationViewController"
    lazy var registrationView = RegistrationView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
    var registrationCheker: RegistrationChecker?
    //    lazy var logInView: RegistrationView = {
    //       let view = RegistrationView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
    //        view.emailTextField.alpha = 0
    //        view.confirmPasswordTextField.alpha = 0
    //        return view
    //    }()
    
    private let numberString: [String] = (0...9).map { String($0) }
    private let alphabet = [
        "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"
    ]
    let ref = Database.database().reference(fromURL: "https://netflixclone-343110-default-rtdb.firebaseio.com/")
    //    let ref = Database.database().reference()
    private var isDoingSigIn: Bool!
    private var user: UserData!
    var tag: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
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
        registrationView.segmentControl.addTarget(self, action: #selector(setup(_ :)), for: .allEvents)
        registrationView.button.addTarget(self, action: #selector(registrait), for: .touchUpInside)
        
    }
    
    @objc func registrait(_ sender: UIButton) {
        let tbVc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarController")
        if isDoingSigIn {
            let email = registrationView.emailTextField.text?.trimmingCharacters(in: .whitespaces)
            let password = registrationView.passwordTextField.text?.trimmingCharacters(in: .whitespaces)
            
            Auth.auth().signIn(withEmail: email!, password: password!) { [weak self] user, error in
                if  error != nil {
                    self?.showAlertWith(title: "ERROR", text: "\(error!.localizedDescription)")
                } else {
                    self?.navigationController?.pushViewController(tbVc, animated: true)
                }
            }
        } else {
            user = UserData(firstName: registrationView.firstNameTextField.text ?? "",
                            lastName: registrationView.lastNameTextField.text ?? "",
                            mail: registrationView.emailTextField.text ?? "",
                            password: registrationView.passwordTextField.text ?? "",
                            seenMoviesList: [])
            doRegistarion(of: user)
            self.navigationController?.pushViewController(tbVc, animated: true)
        }
        
    }
    
    @objc func setup(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            registrationView.lastNameTextField.isHidden = true
            registrationView.firstNameTextField.isHidden = true
            registrationView.confirmPasswordTextField.isHidden = true
            isDoingSigIn = true
        case 1:
            registrationView.lastNameTextField.isHidden = false
            registrationView.firstNameTextField.isHidden = false
            registrationView.confirmPasswordTextField.isHidden = false
            isDoingSigIn = false
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
        clearTextFields()
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
    
    func clearTextFields() {
        registrationView.firstNameTextField.text = ""
        registrationView.emailTextField.text = ""
        registrationView.passwordTextField.text = ""
        registrationView.confirmPasswordTextField.text = ""
    }
}

extension RegistrationViewController1: RegistrationChecker {
    
    func doRegistarion(of user: UserData) {
        checkAllFields(user)
        saveUserData(user)
    }
    
    func saveUserData(_ userData: UserData) {
        Auth.auth().createUser(withEmail: userData.mail, password: userData.password) { [weak self] user, error in
            if error == nil {
                self?.ref.child("Users").child(user!.user.uid).setValue(["firstName": userData.firstName, "lastName": userData.lastName, "email": userData.mail, "movies": []])
            } else {
                self?.showAlertWith(title: "ERROR", text: "This user already exist")
            }
        }
    }
    
    func checkAllFields(_ user: UserData) {
        switch false {
        // If this user name is not in core data then add this user to core data
        case !(user.lastName.isEmpty ||
                user.mail.isEmpty ||
                user.password.isEmpty ||
                registrationView.confirmPasswordTextField.text!.isEmpty ||
                registrationView.firstNameTextField.text!.isEmpty):
            showAlertWith(title: "ERROR", text: "Please fill in all fields")
        case checkEmailValidation(user.mail):
            showAlertWith(title: "ERROR", text: "Email is not valid")
        case checkPasswordValidation(user.password):
            showAlertWith(title: "ERROR", text: "This password is not secure")
        case confirmPassword(user.password, registrationView.confirmPasswordTextField.text ?? ""):
            showAlertWith(title: "ERROR", text: "Passwords doesn't match")
        default:
            break
        //                showSuccessMessageAndGoBackToLogIn()
        }
    }
    
    //    func showSuccessMessageAndGoBackToLogIn() {
    //        let alert = UIAlertController(title: "SUCCESS", message: "\nRegistration completed Successfully\nClick 'OK' to return to the LogIn page", preferredStyle: .alert)
    //        let action = UIAlertAction(title: "OK", style: .default) { [weak self] (result: UIAlertAction) -> Void in
    //            self?.delegat?.getInfo(user: self!.user)
    //            self?.navigationController?.popViewController(animated: true)
    //        }
    //        alert.addAction(action)
    //        alert.view.tintColor = .green
    //        present(alert, animated: true, completion: nil)
    //    }
    
    func showAlertWith(title: String, text: String) {
        let alert = UIAlertController(title: title, message: "\n\(text)", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(action)
        alert.view.tintColor = .red
        present(alert, animated: true, completion: nil)
    }
    
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
