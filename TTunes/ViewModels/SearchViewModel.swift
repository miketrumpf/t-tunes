//
//  SearchViewModel.swift
//  TTunes
//
//  Created by Mike on 9/27/17.
//

import Foundation
import UIKit


protocol SearchViewModelDelegate: class {
  func resultsDidLoad()
  func throwError()
  func imagesDidLoad()
}
class SearchViewModel: NSObject {
  var resultsArray = [ResultModel]()
  var resultsImages = [UIImage]()
  weak var delegate: SearchViewModelDelegate?

  
  //fetch Results based on search term.
  func fetchResults(searchParams: String) {
    SearchContentManager.fetchResults(searchParams: searchParams){ [weak self] (resultArray) in
      
      guard resultArray != nil else {
        //call delegate for no results
        self?.delegate?.throwError()
        return
      }
      self?.resultsArray = resultArray!
      self?.delegate?.resultsDidLoad()
    }
  }
  
  //after receiving the results and caching them, make the calls to download the album images
  func getResultsImages() {
    
    SearchContentManager.getResultsImages(resultsArray: resultsArray) {[weak self] (imageArray) in
      //fix
      guard imageArray != nil else {
        return
      }
      
      self?.resultsImages = imageArray!
      self?.delegate?.imagesDidLoad()
    }
  }
  func resultsDidLoad() {


  }

  
  
  
}
