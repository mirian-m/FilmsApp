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
    func displayAlert(viewModel:Details.GetError.ViewModel)
}

final class DetailsViewController: BackgroundViewControlller {
    
    //  MARK:- Clean Components
    var interactor: DetailsBusinessLogic?
    var router: (NSObjectProtocol & DetailsRoutingLogic & DetailsDataPassing)?
    
    //  MARK:- object
    private lazy var detailsTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(DetailsCell.self, forCellReuseIdentifier: DetailsCell.identifier)
        tableView.register(MoreDetailsTableViewCell.self, forCellReuseIdentifier: MoreDetailsTableViewCell.identifier)
        tableView.register(Overview.self, forCellReuseIdentifier: Overview.identifier)
        tableView.register(MoviesTableViewCell.self, forCellReuseIdentifier: MoviesTableViewCell.identifier)
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.frame = self.view.bounds
        tableView.backgroundColor = Constants.Design.Color.Background.None
        view.addSubview(tableView)
        return tableView
    }()
    
    private lazy var headerView = Poster(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height * 0.55))
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
    
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        controllerSetup()
        getMovieDetails()
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

    private func controllerSetup() {
        
        //  MARK:- Add NotificationCenter Observer
        NotificationCenter.default.addObserver(self, selector: #selector(playTrailer), name: .playButtonWasClicked, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(moveBack), name: .moveBackButtonTapped, object: nil)
        navigationController?.setNavigationBarHidden(true, animated: false)
        detailsTableView.tableHeaderView = headerView
    }
    
    //  MARK:- Buttons Action
    @objc private func playTrailer() {
        interactor?.updateUserWatchedList(request: Details.UpdateUserData.Request(movieId: movieViewModel.id))
        router?.routeToTraileVc(segue: nil)
    }
    @objc private func moveBack() {
        router?.routeToBack(segue: nil)
    }
    func getMovieDetails() {
        let request = Details.GetMovie.Request()
        interactor?.getMoveDetails(request: request)
    }
}

extension DetailsViewController: DetailsDisplayLogic {
    
    //  MARK:- Display logic methods
    func displayAlert(viewModel: Details.GetError.ViewModel) {
        self.showAlertWith(title: viewModel.errorModel.title, text: viewModel.errorModel.message)
    }
    
    func displayMovieDetails(viewModel: Details.GetMovie.ViewModel) {
        headerView.configure(with: viewModel.movieViewModel.imageUrl, buttonsIsHidden: false)
        self.movieViewModel = viewModel.movieViewModel
        detailsTableView.reloadData()
    }
}

extension DetailsViewController: UITableViewDataSource, UITableViewDelegate {
    
    //  MARK:- Tableview dataSource & delegat methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 3 }
    
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
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Overview.identifier, for: indexPath) as? Overview else { return UITableViewCell() }
            cell.configur(with: movieViewModel)
            return cell
        default:
            break
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.row > 1 ? Constants.Content.Category.Height.max : Constants.Content.Category.Height.min
    }
}
