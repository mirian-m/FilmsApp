
import UIKit
import FirebaseStorage

protocol HomeDisplayLogic: AnyObject {
    func displayMovies(viewModel: Home.MovieInfo.ViewModel)
    func displayAlert(viewModel: Home.Error.ViewModel)
    func displaySelectedMovie(viewModel: Home.GetSelectedMovie.ViewModel)
}

final class HomeViewController: BackgroundViewControlller {
    
    //  MARK:- Clean Components
    var interactor: HomeBusinessLogic?
    var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?
    
    //  MARK: @IBOutlet
    @IBOutlet weak var filmTableView: UITableView! {
        didSet {
            filmTableView.contentInsetAdjustmentBehavior = .never
        }
    }
    
    //  MARK:- Fields
    private var offsets = [IndexPath: CGFloat]()
    private let headerForSection = ["Now playing", "Top", "Popular", "Trending movies", "Upcoming movies"]
    private var headerView: Poster?
    private var posterIsSeted = false
    private var fetchedMoviesDetails: [MovieViewModel] = []
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        controllerSetup()
    }
    
    // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    private func setup() {
        let viewController = self
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func controllerSetup() {
        tabBarController?.navigationItem.hidesBackButton = true
        tabBarController?.navigationController?.navigationBar.isHidden = false
        tabBarItem.badgeColor = .label
        tabBarItem.image = Constants.Design.Image.Icon.Home?.withRenderingMode(.automatic)
        tabBarItem.title = "Home"
        
        headerView = Poster(frame: CGRect(x: 0,
                                          y: 0,
                                          width: HomeVcConst.posterWidth,
                                          height: HomeVcConst.posterHeight))
        filmTableView.tableHeaderView = headerView
        setNavBarItems()
    }
    
    //  MARK:- Set Navigation button image
    private func setNavBarItems() {
        let image = Constants.Design.Image.Logo.LogoImageOne?.withRenderingMode(.alwaysOriginal)
        tabBarController?.navigationItem.leftBarButtonItem  = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
    }

}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    //  MARK:- Tableview DataSource & Delegate Methods
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesTableViewCell", for: indexPath) as? MoviesTableViewCell else { return UITableViewCell() }
        
        cell.setScrollPosition(x: offsets[indexPath] ?? 0)
        let request = Home.MovieInfo.Request(section: indexPath.section, sectionTitle: headerForSection[indexPath.section])
        interactor?.fetchMovies(request: request)
        
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.Content.Category.Height.middle
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        headerForSection.count
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = Constants.Design.Font.HeadingTwo
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x, y: header.bounds.origin.y, width: 100, height: 50)
        header.textLabel?.textColor = Constants.Design.Color.Primary.White
        header.textLabel?.text = header.textLabel?.text?.upperCasedFirstLetter()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        headerForSection[section]
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        offsets[indexPath] = (cell as? MoviesTableViewCell)?.getScrollPosition()
    }
}

extension HomeViewController: HomeDisplayLogic {
    
    //  MARK:- DisplayLogic Functions
    
    func displayMovies(viewModel: Home.MovieInfo.ViewModel) {
        self.fetchedMoviesDetails = viewModel.movies ?? []
        
        // Get current cell
        guard let cell = filmTableView.cellForRow(at: IndexPath(row: 0, section: viewModel.section)) as? MoviesTableViewCell else { return }
        cell.updateViewFromModel(movies: self.fetchedMoviesDetails)
        
        // Set Poster
        if !posterIsSeted {
            guard let randomMovie = viewModel.movies?.randomElement() else { return }
            self.headerView?.configure(with: randomMovie.imageUrl, buttonsIsHidden: true)
            self.posterIsSeted = true
        }
    }
    
    //  MARK:-  Aler Method
    func displayAlert(viewModel: Home.Error.ViewModel) {
        self.showAlertWith(title: viewModel.errorModel.title, text: viewModel.errorModel.message)
    }
    
    func displaySelectedMovie(viewModel: Home.GetSelectedMovie.ViewModel) {
        router?.routToDetailsVc()
    }
}

extension HomeViewController: CollectionViewTableViewCelldelegate {
    
    //  MARK: Delegate Protocol FUNCtions
    func collectionViewTableViewCellDidTap(movieId: Int) {
        interactor?.getSelectedMovieDetails(requset: Home.GetSelectedMovie.Request(selectedMovieId: movieId))
    }
}
