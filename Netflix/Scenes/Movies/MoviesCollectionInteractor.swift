//
//  MoviesCollectionInteractor.swift
//  Netflix
//
//  Created by Admin on 8/29/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol MoviesCollectionBusinessLogic
{
  func doSomething(request: MoviesCollection.Something.Request)
}

protocol MoviesCollectionDataStore {
  //var name: String { get set }
}

class MoviesCollectionInteractor: MoviesCollectionBusinessLogic, MoviesCollectionDataStore {
  var presenter: MoviesCollectionPresentationLogic?
  var worker: MoviesCollectionWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: MoviesCollection.Something.Request)
  {
    worker = MoviesCollectionWorker()
    worker?.doSomeWork()
    
    let response = MoviesCollection.Something.Response()
    presenter?.presentSomething(response: response)
  }
}
