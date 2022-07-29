
import UIKit

protocol SearchResultViewControllerDelegat: AnyObject {
    func SearchResultViewControllerDidSelet(with model: TrailerViewModel)
}

class SearchResultViewController: UIViewController {
    var details = [Details]()
    
    public weak var delegat: SearchResultViewControllerDelegat!
    
    var searchResultCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(SearchCollectionViewcell.self, forCellWithReuseIdentifier: SearchCollectionViewcell.identifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        searchResultCollectionView.dataSource = self
        searchResultCollectionView.delegate = self
        view.addSubview(searchResultCollectionView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultCollectionView.frame = view.bounds
    }
}
// Create search result collection view
extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { details.count }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewcell.identifier, for: indexPath) as? SearchCollectionViewcell else{return UICollectionViewCell()}
        let posterURL = Constant.PosterBaseURL + (details[indexPath.row].poster_path ?? "")
        cell.posterImage.getImageFromWeb(by: posterURL)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let title = details[indexPath.row].name ?? details[indexPath.row].original_name ?? ""
        let overview = details[indexPath.row].overview

        APIColler.shared.getMovie(with: title + " trailer") { [weak self](result) in
            switch result {
            case .success(let result):
                self?.delegat.SearchResultViewControllerDidSelet(with: TrailerViewModel(movieTitle: title, overview: overview, youtubeId: result.items[0].id))
            case .failure(let error):
                print(error)
            }
        }
    }
}
