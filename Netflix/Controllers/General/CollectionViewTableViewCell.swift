import UIKit

protocol CollectionViewTableViewCelldelegat: class {
    func collectionViewTableViewCellDidTap(cell: CollectionViewTableViewCell, model: TrailerViewModel)
}

class CollectionViewTableViewCell: UITableViewCell {
    var movies = Movies(details: [])
    var tvShow = Tv(details: [])
    weak var delegat: CollectionViewTableViewCelldelegat!
    
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func updateViewFromModel(movies: Any){
        DispatchQueue.main.async {[weak self] in
            if (movies as? Movies) != nil {
                self?.movies = (movies as? Movies)!
                self?.movies.details.shuffle()
            }else{
                self?.tvShow = (movies as? Tv)!
            }
            self?.collectionView.reloadData()
        }
    }
}

// Create Collection View in Table View
extension CollectionViewTableViewCell: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.details.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let collection = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell else{return UICollectionViewCell()}
        var url: String!
        url = movies.details[indexPath.row].poster_path
        url = Constant.PosterBaseURL + url
        collection.posterImage.getImageFromWeb(by: url)
        return collection
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: 120, height: 150)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        var title: String!
        var overview: String!
        title = (movies.details[indexPath.row].original_name ?? movies.details[indexPath.row].name) ?? " "
        overview = movies.details[indexPath.row].overview
        
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
