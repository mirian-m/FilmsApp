import UIKit

class Poster: UIView {
    var posterUrl: String?
    
    private var backBtn: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let buttonImage = UIImage(systemName: "chevron.backward")?.withTintColor(UIColor.white, renderingMode: .alwaysOriginal)
        button.layer.cornerRadius = 25
        button.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.2)
        button.setImage(buttonImage, for: .normal)
        button.addTarget(self, action: #selector(navigateBack), for: .touchUpInside)
        return button
    }()
    
    private var playButton: UIButton = {
        var button = UIButton()
        let buttonImage = UIImage(named: "PlayIcon")
        button.setImage(buttonImage, for: .normal)
        button.contentMode = .scaleAspectFill
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(postNotification), for: .touchUpInside)
        return button
    }()
    
    private lazy var posterView: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "defaultImage")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(posterView)
        addSubview(playButton)
        addSubview(backBtn)
        addGratient()
        addButtonConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterView.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure(with posterUrl: String, buttonsIsHidden: Bool) {
        let url =  Constants.API.Movies.Helper.PosterBaseURL + posterUrl
        backBtn.isHidden = buttonsIsHidden
        playButton.isHidden = buttonsIsHidden
        posterView.getImageFromWeb(by: url)
    }
    
    @objc func postNotification() {
        NotificationCenter.default.post(name: .playButtonTap, object: self)
    }
    
    @objc func navigateBack() {
        NotificationCenter.default.post(name: .navButtonTap, object: self)
    }
}

extension Poster {
    
    private func addGratient() {
        let layer = CAGradientLayer()
        layer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        layer.frame = bounds
        self.layer.addSublayer(layer)
        
    }
    //  MARK:- Constraints
    private func addButtonConstraints(){
        
        let playButtonConstraints = [
            playButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            playButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            playButton.widthAnchor.constraint(equalToConstant: 64),
            playButton.heightAnchor.constraint(equalTo: playButton.widthAnchor, multiplier: 1)
        ]
        
        let backBtnConstraints = [
            backBtn.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            backBtn.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            backBtn.widthAnchor.constraint(equalToConstant: 50),
            backBtn.heightAnchor.constraint(equalTo: backBtn.widthAnchor, multiplier: 1)
        ]
        
        NSLayoutConstraint.activate(playButtonConstraints)
        NSLayoutConstraint.activate(backBtnConstraints)
    }
}
