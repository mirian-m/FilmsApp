//  BottomSheetCustomView.swift
//  Netflix
//  Created by Admin on 9/16/22.

import UIKit

final class BottomSheetCustomView: UIView {
    
    private lazy var bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        addSubview(view)
        return view
    }()
    
    private lazy var questionLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "Are you sure you want to quit?"
        lb.textColor = .white
        bottomView.addSubview(lb)
        return lb
    }()
    
    private lazy var yesBtn: UIButton = {
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
    
    private lazy var noBtn: UIButton = {
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .none
        bottomView.backgroundColor = .black
        adjustContraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  MARK:- Button actions
    @objc private func sigOutFromProfile() {
        NotificationCenter.default.post(name: .yesButtonWasClickedOnTheBottomSheet, object: nil)
    }

    @objc private func dismissController() {
        NotificationCenter.default.post(name: Notification.Name("Dismiss"), object: nil)
    }
    
    //  MARK:- Adjust contraints Method
    private func adjustContraints() {
        let bottomViewConstreints = [
            bottomView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            bottomView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            bottomView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            bottomView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: 30)
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
