//  WelcomeViewController.swift
//  Netflix
//  Created by Admin on 7/30/22.

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var sigInBtn: UIButton! {
        didSet {
            sigInBtn.tintColor = .white
        }
    }
    
    @IBOutlet weak var getStaredBtn: UIButton! {
        didSet {
            getStaredBtn.layer.backgroundColor = UIColor(red: 0.824, green: 0.184, blue: 0.149, alpha: 1).cgColor
            getStaredBtn.layer.cornerRadius = 2
            getStaredBtn.tintColor = .white
            getStaredBtn.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 18)
        }
    }
    
    @IBOutlet weak var lb: UILabel! {
        didSet {
            lb.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            lb.font = UIFont(name: "Helvetica Neue", size: 32)
            lb.textAlignment = .center
        }
    }
    
    @IBOutlet weak var lb2: UILabel! {
        didSet {
            lb2.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            lb2.font = UIFont(name: "Helvetica Neue", size: 18)
            lb2.textAlignment = .center
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func moveToRegitrationPage(_ sender: Any) {
        guard let cv = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: RegistrationViewController.identifier) as? RegistrationViewController else { return }
//        let cv = RegistrationViewController()
        guard let tag = (sender as? UIButton)?.tag else { return }
        cv.tag = tag
        self.navigationController?.pushViewController(cv, animated: true)
    }
}
