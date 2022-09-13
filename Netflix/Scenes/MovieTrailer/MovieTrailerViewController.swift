//
//  MovieTrailerViewController.swift
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
import WebKit

protocol MovieTrailerDisplayLogic: class {
    func displayMovieTrailer(viewModel: MovieTrailer.GetTrailer.ViewModel)
}

final class MovieTrailerViewController: UIViewController, MovieTrailerDisplayLogic {
    
    //  MARK:- Clean Components
    var interactor: MovieTrailerBusinessLogic?
    var router: (NSObjectProtocol & MovieTrailerRoutingLogic & MovieTrailerDataPassing)?
    
    //  MARK: - Fields
    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    private lazy var titleLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.numberOfLines = 0
        lb.font = Constants.Design.Font.HeadingOne
        return lb
    }()
    
    private lazy var overviewLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.minimumScaleFactor = 10
        lb.font = Constants.Design.Font.Sub
        lb.numberOfLines = 0
        return lb
    }()
    
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
        navigationController?.setNavigationBarHidden(false, animated: true)
        setupController()
        doSomething()
    }
    
    // MARK: Setup
    private func setup() {
        let viewController = self
        let interactor = MovieTrailerInteractor()
        let presenter = MovieTrailerPresenter()
        let router = MovieTrailerRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setupController() {
        navigationController?.navigationBar.tintColor = .white
        view.backgroundColor = .systemBackground
        view.addSubview(webView)
        view.addSubview(titleLb)
        view.addSubview(overviewLb)
        setConstraints()
    }
    
    func doSomething() {
        let request = MovieTrailer.GetTrailer.Request()
        interactor?.getTrailer(request: request)
    }
    
    func displayMovieTrailer(viewModel: MovieTrailer.GetTrailer.ViewModel) {
        self.titleLb.text = viewModel.trailer.movieTitle
        self.overviewLb.text = viewModel.trailer.overview
        guard let url = URL(string: "https://www.youtube.com/watch?v=\(viewModel.trailer.youtubeId ?? "")") else { return }
        self.webView.load(URLRequest(url: url))
    }
}

extension MovieTrailerViewController {
    
    //  MARK: - ADD Constraints
    private func setConstraints(){
        let webViewConstraint = [
            webView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: -40),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.heightAnchor.constraint(equalToConstant: 500)
        ]
        
        let titleLbConstraint = [
            titleLb.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 10),
            titleLb.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            titleLb.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ]
        
        let overviewLbconstraint = [
            overviewLb.topAnchor.constraint(equalTo: titleLb.bottomAnchor, constant: 10),
            overviewLb.leadingAnchor.constraint(equalTo: titleLb.leadingAnchor, constant: 10),
            overviewLb.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ]
        
        NSLayoutConstraint.activate(webViewConstraint)
        NSLayoutConstraint.activate(titleLbConstraint)
        NSLayoutConstraint.activate(overviewLbconstraint)
    }
}
