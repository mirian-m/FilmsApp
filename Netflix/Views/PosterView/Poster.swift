import UIKit

class Poster: UIView {
    var posterUrl: String?
    
    private var playButton: UIButton = {
        var button = UIButton()
        let buttonim = UIImage(named: "Play")
        button.setImage(buttonim, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(playTrailer), for: .touchUpInside)
        return button
    }()
    
    private lazy var posterView: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.backgroundColor = .red
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(posterView)
        addSubview(playButton)
        addButtonConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterView.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure(with posterUrl: String){
        let url =  APIConstants.posterBaseURL + posterUrl
        posterView.getImageFromWeb(by: url)
    }
    
    @objc func playTrailer() {
        print("1")
    }
}

extension Poster {
    
    //  MARK:- Constraints
    private func addButtonConstraints(){
        
        let playButtonConstraints = [
            playButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            playButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            playButton.widthAnchor.constraint(equalToConstant: 80),
            playButton.heightAnchor.constraint(equalTo: playButton.widthAnchor, multiplier: 1)
        ]
        
        let posterViewConstraint = [
//            posterView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
//            posterView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            posterView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            posterView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(playButtonConstraints)
        NSLayoutConstraint.activate(posterViewConstraint)
    }
}
