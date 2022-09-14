import UIKit
import FirebaseCore

protocol CollectionViewTableViewCelldelegate: AnyObject {
    func collectionViewTableViewCellDidTap(movieId: Int)
}

class MoviesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var moviesCollectionView: UICollectionView! {
        didSet {
            moviesCollectionView.dataSource = self
            moviesCollectionView.delegate = self
        }
    }
    
    public var movies: [MovieViewModel] = []
    weak var delegate: CollectionViewTableViewCelldelegate?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        moviesCollectionView.backgroundColor = Constants.Design.Color.Background.None
    }
    
    func updateViewFromModel(movies: [MovieViewModel]) {
        DispatchQueue.main.async { [weak self] in
            self?.movies = movies
            self?.moviesCollectionView.reloadData()
        }
    }
}

// MARK:- Create Collection View in Table View

extension MoviesTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func setScrollPosition(x: CGFloat) {
        moviesCollectionView.setContentOffset(CGPoint(x: x, y: 0), animated: false)
    }
    
    func getScrollPosition() -> CGFloat {
        moviesCollectionView.contentOffset.x
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { movies.count }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let collectionView = collectionView.dequeueReusableCell(
                withReuseIdentifier: "CollectionViewCell",
                for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
        
        let imageUrl = movies[indexPath.row].imageUrl
        let url = Constants.API.Movies.Helper.PosterBaseURL + imageUrl
        
        collectionView.loadImage(by: url)
        return collectionView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        CGSize(width: 120, height: Constants.Content.Category.Height.middle)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        self.delegate?.collectionViewTableViewCellDidTap(movieId: movies[indexPath.row].id)
    }
}
