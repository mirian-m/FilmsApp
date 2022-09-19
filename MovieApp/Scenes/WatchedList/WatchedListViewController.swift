//
//  WatchedListViewController.swift
//  Netflix
//
//  Created by Admin on 9/7/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol WatchedListDisplayLogic: AnyObject {
    func displayWatchedMovies(viewModel: WatchedList.GetWatchedMovies.ViewModel)
    func displaySelectedMovie(viewModel: WatchedList.GetSelectedMovie.ViewModel)
    func displayAlert(viewModel:WatchedList.GetError.ViewModel)
}

final class WatchedListViewController: BackgroundImageViewControlller {
    
    //  MARK:- Clean Components
    var interactor: WatchedListBusinessLogic?
    var router: (NSObjectProtocol & WatchedListRoutingLogic & WatchedListDataPassing)?
    
    //  MARK:- Private Var
    private lazy var watchedFilmTableView: UITableView = {
        var table = UITableView()
        table.register(WatchedFilmTableViewCell.self, forCellReuseIdentifier: WatchedFilmTableViewCell.identifier)
        table.dataSource = self
        table.delegate = self
        table.backgroundColor = Constants.Design.Color.Background.None
        view.addSubview(table)
        return table
    }()
    
    private lazy var activateIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        indicator.color = .blue
        view.addSubview(indicator)
        return indicator
    }()
    
    private var watchedListViewModel = [MovieViewModel]()
    
    //  MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    //  MARK: Setup
    private func setup() {
        let viewController = self
        let interactor = WatchedListInteractor()
        let presenter = WatchedListPresenter()
        let router = WatchedListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    //  MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Watched List"
        activateIndicator.startAnimating()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getWatchedMovies()
    }
    
    override func viewDidLayoutSubviews() {
        super .viewDidLayoutSubviews()
        watchedFilmTableView.frame = view.bounds
        activateIndicator.center = view.center
    }
    
    //  MARK: Get Movies
    func getWatchedMovies() {
        let request = WatchedList.GetWatchedMovies.Request()
        interactor?.getWatchedMovies(request: request)
    }
}

extension WatchedListViewController: UITableViewDataSource, UITableViewDelegate {
    
    //  MARK:- TableView DataSource & Delegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        watchedListViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WatchedFilmTableViewCell.identifier, for: indexPath) as? WatchedFilmTableViewCell else { return UITableViewCell() }
        let movies = watchedListViewModel[indexPath.row]
        cell.configure(with: movies)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        interactor?.didTapMovie(requset: WatchedList.GetSelectedMovie.Request(selectedMovieId: watchedListViewModel[indexPath.row].id))
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { Constants.Content.Category.Height.middle }
}

extension WatchedListViewController:  WatchedListDisplayLogic {
    //  MARK:- DisplayLogic Protocol Function
    func displaySelectedMovie(viewModel: WatchedList.GetSelectedMovie.ViewModel) {
        router?.routeToTrailerVC(segue: nil)
    }
    
    func displayWatchedMovies(viewModel: WatchedList.GetWatchedMovies.ViewModel) {
        activateIndicator.stopAnimating()
        self.watchedListViewModel = viewModel.watchedMoviesModel
        self.watchedListViewModel = Array(Set(self.watchedListViewModel)).sorted(by: { $0.title < $1.title })
        self.watchedFilmTableView.reloadData()
    }
    
    func displayAlert(viewModel: WatchedList.GetError.ViewModel) {
        showAlertWith(title: viewModel.errorModel.title, text: viewModel.errorModel.message)
    }

}

extension WatchedListViewController: WatchedFilmTableViewCellDelegate {
    
    //  MARK:- Remove Movie From Watched List
    func removeMovieFromList(by movieId: Int) {
        interactor?.removeMovieFromWatchedList(request: WatchedList.RemoveSelectedMovie.Request(selectedMovieId: movieId))
    }
}
