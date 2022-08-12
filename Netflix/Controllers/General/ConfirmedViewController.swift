import UIKit

protocol ConfirmedViewControllerDelegate: AnyObject {
    func signOutFromProfile()
}

class ConfirmedViewController: UIViewController {
    lazy var bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        self.view.addSubview(view)
        return view
    }()
    
    lazy var questionLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "Are you sure you want to quit?"
        lb.textColor = .white
        bottomView.addSubview(lb)
        return lb
    }()
    
    lazy var yesBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Yes", for: .normal)
        btn.backgroundColor = .green
        btn.layer.cornerRadius = 5
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(sigOutFromProfile), for: .allEvents)
        self.bottomView.addSubview(btn)
       return btn
    }()
    
    lazy var noBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("No", for: .normal)
        btn.backgroundColor = .red
        btn.layer.cornerRadius = 5
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(dismissController), for: .allEvents)
        self.bottomView.addSubview(btn)
       return btn
    }()
    
    weak var delegate: ConfirmedViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .none
        bottomView.backgroundColor = .black
        adjustContraints()
    }
    
    @objc func sigOutFromProfile() {
        dismiss(animated: true) {
            self.delegate?.signOutFromProfile()
        }
    }
    
    @objc func dismissController() {
        dismiss(animated: true, completion: nil)
    }
    func adjustContraints() {
        let bottomViewConstreints = [
            bottomView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            bottomView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.5),
            bottomView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            bottomView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: 30)
        ]
        
        let yesBtnConstreints = [
            yesBtn.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor, constant: -100),
            yesBtn.topAnchor.constraint(equalTo: questionLb.bottomAnchor, constant: 40),
            yesBtn.widthAnchor.constraint(equalToConstant: 70)
        ]
        
        let noBtnConstraints = [
            noBtn.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor, constant: 100),
            noBtn.topAnchor.constraint(equalTo: yesBtn.topAnchor),
            noBtn.widthAnchor.constraint(equalTo: yesBtn.widthAnchor)
            
        ]
        
        let questionLbConstraints = [
            questionLb.topAnchor.constraint(equalTo: bottomView.safeAreaLayoutGuide.topAnchor, constant: 40),
            questionLb.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor)
            
        ]
        NSLayoutConstraint.activate(bottomViewConstreints)
        NSLayoutConstraint.activate(yesBtnConstreints)
        NSLayoutConstraint.activate(noBtnConstraints)
        NSLayoutConstraint.activate(questionLbConstraints)
    }

}
