//
//  SearchMovieViewController.swift
//  Netflix
//
//  Created by Admin on 9/5/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol SearchMovieDisplayLogic: AnyObject {
    func displayMovies(viewModel: SearchMovie.GetMovies.ViewModel)
    func displaySelectedMovie(vieModel: SearchMovie.GetSelectedMovie.ViewModel)
    func displaySearchedMovies(viewModel: SearchMovie.GetSearchedMovies.ViewModel)
    func displayAlert(viewModel: SearchMovie.GetError.ViewModel)
}

final class SearchMovieViewController: BackgroundViewControlller {
    
    //  MARK:- Clean Components
    var interactor: SearchMovieBusinessLogic?
    var router: (NSObjectProtocol & SearchMovieRoutingLogic & SearchMovieDataPassing)?
    
    
    let searchController: UISearchController = {
        var controller = UISearchController(searchResultsController: SearchResultViewController())
        controller.searchBar.placeholder = "Search Movie or TV Show "
        controller.searchBar.searchBarStyle = .minimal
        controller.searchBar.backgroundColor = Constants.Design.Color.Background.Light
        return controller
    }()
    
    private lazy var discoveredTable: UITableView = {
        var table = UITableView()
        table.register(MovieCell.self, forCellReuseIdentifier: MovieCell.identifier)
        table.backgroundColor = Constants.Design.Color.Background.None
        table.dataSource = self
        table.delegate = self
        view.addSubview(table)
        return table
    }()
    
    private var moviesViewModel = [MovieViewModel]()
    
    //  MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    //  MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        controllerSetup()
        getMovies()
    }
    
    override func viewDidLayoutSubviews() {
        super .viewDidLayoutSubviews()
        discoveredTable.frame = view.bounds
    }
    
    //  MARK: Setup
    private func setup() {
        let viewController = self
        let interactor = SearchMovieInteractor()
        let presenter = SearchMoviePresenter()
        let router = SearchMovieRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    //  MARK:- Controller Setup
    private func controllerSetup() {
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        navigationController?.navigationBar.tintColor = Constants.Design.Color.Primary.White
        searchController.searchResultsUpdater = self
    }
    
    //  MARK: Do something
    private func getMovies() {
        let request = SearchMovie.GetMovies.Request()
        interactor?.getMovies(request: request)
    }
}

extension SearchMovieViewController: UITableViewDataSource, UITableViewDelegate {
    
    //  MARK: - DataSource & Delegat Function
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { moviesViewModel.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell else { return UITableViewCell() }
        let movieModel = moviesViewModel[indexPath.row]
        cell.configure(with: movieModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        interactor?.didTapMovie(requset: SearchMovie.GetSelectedMovie.Request(selectedMovieId: moviesViewModel[indexPath.row].id))
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { Constants.Content.Category.Height.middle }
}

extension SearchMovieViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        interactor?.updateSearchResult(requset: SearchMovie.GetSearchedMovies.Request(query: searchBar.text))
    }
}

extension SearchMovieViewController: SearchMovieDisplayLogic {
    
    
    //  MARK: DisplayLogic Protocol Functions
    func displayMovies(viewModel: SearchMovie.GetMovies.ViewModel) {
        moviesViewModel = viewModel.movie?.shuffled() ?? []
        self.discoveredTable.reloadData()
    }
    
    func displaySelectedMovie(vieModel: SearchMovie.GetSelectedMovie.ViewModel) {
        router?.routeToDetailsrVC()
    }
    
    func displaySearchedMovies(viewModel: SearchMovie.GetSearchedMovies.ViewModel) {
        self.router?.routeToSearcheResulte()
    }
    func displayAlert(viewModel: SearchMovie.GetError.ViewModel) {
        self.showAlertWith(title: viewModel.errorModel.title, text: viewModel.errorModel.message)
    }
}
