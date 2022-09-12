//
//  DetailsViewController.swift
//  Netflix
//
//  Created by Admin on 9/8/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol DetailsDisplayLogic: AnyObject {
    func displayMovieDetails(viewModel: Details.GetMovie.ViewModel)
}

final class DetailsViewController: BackgroundImageViewControlller {
    
    //  MARK:- Clean Components
    var interactor: DetailsBusinessLogic?
    var router: (NSObjectProtocol & DetailsRoutingLogic & DetailsDataPassing)?
    
    private lazy var detailsTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(DetailsCell.self, forCellReuseIdentifier: DetailsCell.identifier)
        tableView.register(MoreDetailsTableViewCell.self, forCellReuseIdentifier: MoreDetailsTableViewCell.identifier)
        tableView.register(DetailsOverviewCell.self, forCellReuseIdentifier: DetailsOverviewCell.identifier)
        tableView.frame = self.view.bounds
        tableView.backgroundColor = .none
        view.addSubview(tableView)
        return tableView
    }()
    
    private var headerView: Poster?
    private var movieViewModel = MovieViewModel()
    
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
        let interactor = DetailsInteractor()
        let presenter = DetailsPresenter()
        let router = DetailsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        controllerSetup()
        getMovieDetails()
    }
    
    private func controllerSetup() {
        
        // Add Observer To playButtonDidTapped Notifications
        NotificationCenter.default.addObserver(self, selector: #selector(playTrailer), name: .playButtonDidTapped, object: nil)
        
        navigationController?.navigationBar.barStyle = .black
        
        headerView = Poster(frame: CGRect(
                                x: 0,
                                y: 0,
                                width: view.bounds.width,
                                height: UIScreen.main.bounds.height * 0.45)
        )
        detailsTableView.tableHeaderView = headerView
    }
    
    @objc func playTrailer() {
        interactor?.updateUserWatchedList(request: Details.UpdateUserData.Request(movieId: movieViewModel.id))
        router?.routeToTraileVc(segue: nil)
    }
    func getMovieDetails() {
        let request = Details.GetMovie.Request()
        interactor?.getMoveDetails(request: request)
    }
}

extension DetailsViewController: DetailsDisplayLogic {
    func displayMovieDetails(viewModel: Details.GetMovie.ViewModel) {
        headerView?.configure(with: viewModel.movieViewModel.imageUrl, backButtonIsHidden: false)
        self.movieViewModel = viewModel.movieViewModel
        detailsTableView.reloadData()
    }
}

extension DetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailsCell.identifier, for: indexPath) as? DetailsCell else { return UITableViewCell() }
            cell.configure(with: movieViewModel)
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MoreDetailsTableViewCell.identifier, for: indexPath) as? MoreDetailsTableViewCell else { return UITableViewCell() }
            cell.configure(with: movieViewModel)
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailsOverviewCell.identifier, for: indexPath) as? DetailsOverviewCell else { return UITableViewCell() }
            cell.configur(with: movieViewModel)
            return cell
        default:
            break
        }
        return UITableViewCell()
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.row > 1 ? MovieDetailsVCConst.overViewCellHeight : MovieDetailsVCConst.detailCellHeight
    }
}