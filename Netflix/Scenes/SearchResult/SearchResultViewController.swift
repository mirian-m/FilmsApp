//
//  SearchResultViewController.swift
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

protocol SearchResultDisplayLogic: class {
    func displaySearchResult(viewModel: SearchResult.GetSearchResult.ViewModel)
    func displaySelectedMovie(viewModel: SearchResult.MovieDetail.ViewModel)
}

class SearchResultViewController: BackgroundImageViewControlller, SearchResultDisplayLogic {
    
    private var searchResultCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: Constans.heightForRow)
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(SearchCollectionViewcell.self, forCellWithReuseIdentifier: SearchCollectionViewcell.identifier)
        return collectionView
    }()
    
    private var moviesViewModel: [MovieViewModel] = []
    var interactor: SearchResultBusinessLogic?
    var router: (NSObjectProtocol & SearchResultRoutingLogic & SearchResultDataPassing)?
    
    var searchResultIsUpdated: Bool = false {
        didSet {
            getSearchResult()
            searchResultCollectionView.reloadData()
        }
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
        let interactor = SearchResultInteractor()
        let presenter = SearchResultPresenter()
        let router = SearchResultRouter()
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
        searchResultCollectionView.dataSource = self
        searchResultCollectionView.delegate = self
        view.addSubview(searchResultCollectionView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultCollectionView.frame = view.bounds
    }
    
    //  MARK: Do something
    
    func getSearchResult() {
        let request = SearchResult.GetSearchResult.Request()
        interactor?.getSearchResult(request: request)
    }
    
    func displaySearchResult(viewModel: SearchResult.GetSearchResult.ViewModel) {
        self.moviesViewModel = viewModel.movieViewModel
    }
    
    func displaySelectedMovie(viewModel: SearchResult.MovieDetail.ViewModel) {
        router?.routeToTrailerVC(segue: nil)
    }
    
}

extension SearchResultViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    //  MARK:- CollectionView DataSource & Delegate Functions
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { moviesViewModel.count }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewcell.identifier, for: indexPath) as? SearchCollectionViewcell else { return UICollectionViewCell() }
        let posterURL = APIConstants.posterBaseURL + (moviesViewModel[indexPath.row].imageUrl)
        cell.posterImage.getImageFromWeb(by: posterURL)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        interactor?.didTapMovie(requset: SearchResult.MovieDetail.Request(selectedMovieId: moviesViewModel[indexPath.row].id))
    }
}
