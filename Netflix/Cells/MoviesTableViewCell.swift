import UIKit
import FirebaseCore

protocol CollectionViewTableViewCelldelegat: AnyObject {
    func collectionViewTableViewCellDidTap(cell: MoviesTableViewCell, model: TrailerViewModel)
}

class MoviesTableViewCell: UITableViewCell {
    
//    var moviesCollectionView: MoviesCollectionViewController =  MoviesCollectionViewController(coder: NSCoder())!
    @IBOutlet weak var moviesCollectionView: UICollectionView! {
        didSet {
            moviesCollectionView.dataSource = self
            moviesCollectionView.delegate = self
        }
    }
    
    public var movies: [Home.Movies.Details] = []
    weak var delegat: CollectionViewTableViewCelldelegat!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        moviesCollectionView.backgroundColor = .none
    }
    
    func updateViewFromModel(movies: [Home.Movies.Details]) {
        DispatchQueue.main.async { [weak self] in
            self?.movies = movies
            self?.movies.shuffle()
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
        return moviesCollectionView.contentOffset.x
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let collectionView = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
        
        guard let imageUrl = movies[indexPath.row].poster_path else { return UICollectionViewCell() }
        let url = APIConstants.posterBaseURL + imageUrl
        
        collectionView.loadImage(by: url)
        return collectionView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: 120, height: Constans.heightForRow)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let title = (movies[indexPath.row].original_title ?? movies[indexPath.row].title) ?? ""
        let overview = movies[indexPath.row].overview
        
        APIColler.shared.getMovie(with: title + "trailer") { result in
            switch result {
            case .success(let video):
                self.delegat.collectionViewTableViewCellDidTap(cell: self, model: TrailerViewModel(movieTitle: title, overview: overview, youtubeId: video.items[0].id))
            case .failure(let error):
                print (error)
            }
        }
    }
}
