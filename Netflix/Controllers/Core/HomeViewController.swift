import UIKit


class HomeViewController: UIViewController {
    let headerForSection = ["Trending movies","Trending tv","Popular","Upcoming movies","Top"]
    var headerView: Poster?
    
    @IBOutlet weak var filmTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setNavBarItem()
        setRandomPoster()
        headerView = Poster(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: UIScreen.main.bounds.height * (2/3)))
        filmTableView.tableHeaderView = headerView
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setRandomPoster(){
        APIColler.shared.fetchMovieFromAPI(url: API.dictionariOfAPI["Top"]!) { [weak self](result) in
            switch result {
            case .success(let movie):
                let randomPosterUrl = movie.details.randomElement()?.poster_path
                self?.headerView?.configure(with: (randomPosterUrl)!)
            case .failure(let error):
                print(error)
            }
        }
    }
    func setNavBarItem() {
        navigationController?.navigationBar.tintColor = .white
        tabBarItem.badgeColor = .label
        var image = UIImage(named: "Netflix-new")
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: (UIImage(systemName: "person")), style: .done, target: self, action: nil),
            UIBarButtonItem(image: (UIImage(systemName: "play.rectangle")), style: .done, target: self, action: nil)
        ]
    }
}
extension HomeViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        headerForSection.count
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x, y: header.bounds.origin.y, width: 100, height: 50)
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.upperCasedFirstLetter()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headerForSection[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? CollectionViewTableViewCell else{return UITableViewCell()}
        cell.delegat = self
        let title = headerForSection[indexPath.section]
        let url = API.dictionariOfAPI[title]!
        print(indexPath.section)
        APIColler.shared.fetchMovieFromAPI(url: url) {results in
            switch results {
            case .success(let result):
                cell.updateViewFromModel(movies: result)
            case .failure(let error):
                print(error)
            }
        }
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaulteOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y - defaulteOffset
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0,-offset))
        
    }
}
extension HomeViewController: CollectionViewTableViewCelldelegat{
    func collectionViewTableViewCellDidTap(cell: CollectionViewTableViewCell, model: TrailerViewModel) {
        DispatchQueue.main.async {[weak self] in
            let vc =  TrailerVideoViewController()
            vc.configure(with: model)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

