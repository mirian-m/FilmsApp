//  RegistrationViewController.swift
//  Netflix
//  Created by Admin on 7/30/22.

import UIKit

class RegistrationViewController: BackgroundImageViewControlller {
    
    lazy var registrationView = RegistrationView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
    
    var tag: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    func setupViewController() {
        navigationController?.navigationBar.isHidden = false
        navigationItem.backBarButtonItem?.tintColor = .white
        self.view.addSubview(registrationView)
        registrationView.segment.selectedSegmentIndex = tag
        let title = registrationView.segment.titleForSegment(at: tag)
        registrationView.button.setTitle(title, for: .normal)
        registrationView.segment.addTarget(self, action: #selector(setupRegistrationView(_:)), for: .allEvents)
        setupRegistrationView(registrationView.segment)
    }
    
    @objc func setupRegistrationView(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            registrationView.emailTextField.isHidden = true
            registrationView.confirm.isHidden = true
        case 1:
            registrationView.emailTextField.isHidden = false
            registrationView.confirm.isHidden = false
        default:
            return
        }
        let title = registrationView.segment.titleForSegment(at: registrationView.segment.selectedSegmentIndex)
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
