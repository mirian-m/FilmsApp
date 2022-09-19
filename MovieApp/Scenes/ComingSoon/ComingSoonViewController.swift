//
//  ComingSoonViewController.swift
//  Netflix
//
//  Created by Admin on 9/2/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ComingSoonDisplayLogic: AnyObject {
    func displayUpcomingMovies(viewModel: ComingSoon.GetUpcomingMovies.ViewModel)
    func displaySelectedMovie(viewModel: ComingSoon.GetSelectedMovie.ViewModel)
    func displayAlert(viewModel: ComingSoon.GetError.ViewModel)
}

final class ComingSoonViewController: BackgroundImageViewControlller {
    
    //  MARK:- Clean Components
    var interactor: ComingSoonBusinessLogic?
    var router: (NSObjectProtocol & ComingSoonRoutingLogic & ComingSoonDataPassing)?

    private var moviesViewModel = [MovieViewModel]()
    
    private lazy var upcomingMoviesTableView : UITableView = {
        var tableView = UITableView()
        tableView.backgroundColor = Constants.Design.Color.Background.None
        tableView.dataSource = self
        tableView.delegate = self
        tableView.frame = view.bounds
        tableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.identifier)
        view.addSubview(tableView)
        return tableView
    }()
    
    
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
        fetchUpcomingMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    //  MARK: Setup
    private func setup() {
        let viewController = self
        let interactor = ComingSoonInteractor()
        let presenter = ComingSoonPresenter()
        let router = ComingSoonRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
   private func controllerSetup() {
        title = "Upcoming"
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    //  MARK: Fetch Movies
   private func fetchUpcomingMovies() {
        let request = ComingSoon.GetUpcomingMovies.Request()
        interactor?.getUpcomingMovies(request: request)
    }
}

extension ComingSoonViewController: ComingSoonDisplayLogic {
    
    //  MARK:- Display Functions
    func displayUpcomingMovies(viewModel: ComingSoon.GetUpcomingMovies.ViewModel) {
        self.moviesViewModel = viewModel.movie?.shuffled() ?? []
        self.upcomingMoviesTableView.reloadData()
    }
    
    func displaySelectedMovie(viewModel: ComingSoon.GetSelectedMovie.ViewModel) {
        router?.routeToDetailsVc(segue: nil)
    }
    
    func displayAlert(viewModel: ComingSoon.GetError.ViewModel) {
        self.showAlertWith(title: viewModel.errorModel.title, text: viewModel.errorModel.message)
    }
}

extension ComingSoonViewController: UITableViewDataSource, UITableViewDelegate  {
    
    //  MARK:- DataSource & Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        moviesViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell else { return UITableViewCell() }
        let movieModel = moviesViewModel[indexPath.row]
        cell.configure(with: movieModel)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        interactor?.didTapMovie(requset: ComingSoon.GetSelectedMovie.Request(selectedMovieId: moviesViewModel[indexPath.row].id))
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { Constants.Content.Category.Height.middle }
}