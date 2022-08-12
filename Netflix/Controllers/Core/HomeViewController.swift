import UIKit


class HomeViewController:  BackgroundImageViewControlller, ProfileViewControllerDelegate {
    func backToRootViewController() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBOutlet weak var personBtn: UIBarButtonItem! {
        didSet {
            personBtn.image = UIImage(systemName: "person")?.withRenderingMode(.alwaysOriginal).withTintColor(.white)
        }
    }
    @IBOutlet weak var filmTableView: UITableView!
    private var isNavigate: Bool = false
    
    private let headerForSection = ["Trending movies", "Trending tv", "Popular", "Upcoming movies", "Top"]
    private var headerView: Poster?
    private var paintedSection: [Int] = []
    var offsets = [IndexPath: CGFloat]()
    var sigInUserData: UserData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controllerSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        isNavigate = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        if !isNavigate {
            navigationController?.setNavigationBarHidden(true, animated: false)
        }
    }
    
    func controllerSetup() {
        self.tabBarController?.navigationItem.hidesBackButton = true
        
        tabBarItem.badgeColor = .label
        tabBarItem.image = UIImage(systemName: "house.fill")
        tabBarItem.title = "Home"

        headerView = Poster(frame: CGRect(x: 0,
                                          y: 0,
                                          width: view.bounds.width,
                                          height: UIScreen.main.bounds.height * (2/3)))
        filmTableView.tableHeaderView = headerView
        setNavBarItem()
        setRandomPoster()
    }
    
    func setRandomPoster(){
        APIColler.shared.fetchMovieFromAPI(url: API.dictionariOfAPI["Top"]!) { [weak self] result in
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
        var image = UIImage(named: "Netflix-new")
        image = image?.withRenderingMode(.alwaysOriginal)
        
        tabBarController?.navigationItem.leftBarButtonItem  = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        tabBarController?.navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person")?
                                .withTintColor(UIColor(named: "CustomColor")!,
                                               renderingMode: .alwaysOriginal),
                            style: .done, target: self, action: #selector(presentProfile)),
            
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle")?
                                .withTintColor(UIColor(named: "CustomColor")!,
                                               renderingMode: .alwaysOriginal), style: .done, target: self, action: nil)
        ]
        tabBarController?.navigationController?.navigationBar.tintColor = .white

    }
    
    @objc func presentProfile() {
        let vc = ProfileViewController()
        vc.delegate = self
        present(vc, animated: true, completion: nil)
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? MoviesTableView else { return UITableViewCell() }
        cell.setScrollPosition(x: offsets[indexPath] ?? 0)
        
        let title = headerForSection[indexPath.section]
        let url = API.dictionariOfAPI[title]!
//        if !paintedSection.contains(indexPath.section) {
            //            if title == "Trending tv" {
            //                APIColler.shared.fetchTvShowFromAPI(url: url) { results in
            //                    switch results {
            //                    case .success(let results):
            //                        cell.updateViewFromModel(movies: results)
            //                    case .failure(let error):
            //                        print(error)
            //                    }
            //                }
            //            } else {
            APIColler.shared.fetchMovieFromAPI(url: url) { results in
                switch results {
                case .success(let results):
                    cell.updateViewFromModel(movies: results)
                case .failure(let error):
                    print(error)
                }
            }
//        }
        cell.delegat = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        offsets[indexPath] = (cell as! MoviesTableView).getScrollPosition()
    }
    
}

//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let defaulteOffset = view.safeAreaInsets.top
//        let offset = scrollView.contentOffset.y - defaulteOffset
//        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0,-offset))
//
//    }

extension HomeViewController: CollectionViewTableViewCelldelegat {
    
    func collectionViewTableViewCellDidTap(cell: MoviesTableView, model: TrailerViewModel) {
        DispatchQueue.main.async { [weak self] in
            let vc =  TrailerVideoViewController()
            vc.configure(with: model)
            self?.isNavigate = true
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

