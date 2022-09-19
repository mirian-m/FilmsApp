import UIKit

class Poster: UIView {
    var posterUrl: String?
    
    //  MARK: IBOutlet programmatically
    private var backBtn: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let buttonImage = Constants.Design.Image.Icon.Back?.withTintColor(UIColor.black, renderingMode: .alwaysOriginal)
        button.layer.cornerRadius = 25
        button.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.4)
        button.setImage(buttonImage, for: .normal)
        button.addTarget(self, action: #selector(navigateBack), for: .allEvents)
        return button
    }()
    
    private var playButton: UIButton = {
        var button = UIButton()
        let buttonImage = Constants.Design.Image.Icon.Play
        button.setImage(buttonImage, for: .normal)
        button.contentMode = .scaleAspectFill
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(postNotification), for: .allEvents)
        return button
    }()
    
    private lazy var posterView: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = Constants.Design.Image.DefaultMovieImage
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        addSubview(posterView)
        addSubview(playButton)
        addSubview(backBtn)
        addGradient()
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
    
    //  MARK:- Button Metods
    @objc private func postNotification() {
        NotificationCenter.default.post(name: .playButtonTap, object: self)
    }
    
    @objc private func navigateBack() {
        NotificationCenter.default.post(name: .moveBackButtonTapped, object: self)
    }
}

extension Poster {
    
    //  MARK:- Add gradient to the poster image
    private func addGradient() {
        let layer = CAGradientLayer()
        layer.colors = [
            UIColor.clear.cgColor,
            Constants.Design.Color.Background.Light.cgColor
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
            backBtn.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            backBtn.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12),
            backBtn.widthAnchor.constraint(equalToConstant: 50),
            backBtn.heightAnchor.constraint(equalTo: backBtn.widthAnchor, multiplier: 1)
        ]
        
        NSLayoutConstraint.activate(playButtonConstraints)
        NSLayoutConstraint.activate(backBtnConstraints)
    }
}
