import UIKit

protocol CollectionViewTableViewCelldelegat: AnyObject {
    func collectionViewTableViewCellDidTap(cell: CollectionViewTableViewCell, model: TrailerViewModel)
}

class CollectionViewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.backgroundColor = .none
    }
    
    public var movies = Movies(details: [])
    //    var tvShow = Tv(details: [], errorMessage: nil)
    weak var delegat: CollectionViewTableViewCelldelegat!

    func updateViewFromModel(movies: Movies) {
        DispatchQueue.main.async { [weak self] in
            self?.movies = movies
            self?.collectionView.reloadData()
        }
    }
}

// MARK:- Create Collection View in Table View

extension CollectionViewTableViewCell: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.details.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let collectionView = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
        guard let imageUrl = movies.details[indexPath.row].poster_path else { return UICollectionViewCell() }
        
        let url = Constant.PosterBaseURL + imageUrl
        collectionView.loadImage(by: url)
        return collectionView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: 120, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let title = (movies.details[indexPath.row].original_name ?? movies.details[indexPath.row].name) ?? ""
        let overview = movies.details[indexPath.row].overview
        
        APIColler.shared.getMovie(with: title + "trailer") { (result) in
            switch result {
            case .success(let video):
                self.delegat.collectionViewTableViewCellDidTap(cell: self, model: TrailerViewModel(movieTitle: title, overview: overview, youtubeId: video.items[0].id))
            case .failure(let error):
                print (error)
            }
        }
    }
}
