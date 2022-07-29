import UIKit

class ComingSoonViewContorller: BackgroundImageViewControlller {
    var details = [Details]()
    
    private let upcomingMoviesTableView : UITableView = {
        var tableView = UITableView()
        tableView.register(UpcomingCell.self, forCellReuseIdentifier: UpcomingCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controllerSetup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        upcomingMoviesTableView.frame = view.bounds
        
    }
    
    func controllerSetup() {
        title = "Upcoming"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(upcomingMoviesTableView)
        upcomingMoviesTableView.dataSource = self
        upcomingMoviesTableView.delegate = self
        upcomingMoviesTableView.backgroundColor = .none
        fetchUpcomingMovies()

    }
    private func fetchUpcomingMovies() {
        let url = API.dictionariOfAPI["Upcoming movies"]!
        APIColler.shared.fetchMovieFromAPI(url: url) { result in
            switch result {
            case .success(let movies):
                self.details = movies.details
                self.details.shuffle()
                DispatchQueue.main.async { [weak self] in
                    self?.upcomingMoviesTableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
extension ComingSoonViewContorller: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        details.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UpcomingCell.identifier, for: indexPath) as? UpcomingCell else { return UITableViewCell() }
        let movieDetails = details[indexPath.row]
        cell.configure(with: TitleViewModel(titleName: movieDetails.original_name ?? movieDetails.name ?? "Unknon film", posterUrl: movieDetails.poster_path ?? ""))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    
        let title = details[indexPath.row].original_name ?? details[indexPath.row].name ?? ""
        let overview = details[indexPath.row].overview ?? ""
        APIColler.shared.getMovie(with: title + " trailer") { result in
            switch result {
            case .success(let result):
                DispatchQueue.main.async { [weak self] in
                    let vc = TrailerVideoViewController()
                    vc.configure(with: TrailerViewModel(movieTitle: title, overview: overview, youtubeId: result.items[0].id) )
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 140 }
}
