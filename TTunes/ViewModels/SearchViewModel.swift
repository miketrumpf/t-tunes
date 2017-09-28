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
//  func noPosts()
  func imagesDidLoad()
//  func htmlDidLoad()
}
class SearchViewModel: NSObject {
  var resultsArray = [ResultModel]()
  var resultsImages = [UIImage]()
  weak var delegate: SearchViewModelDelegate?

  
  //fetch Results based on search term. //will need to pass params
  func fetchResults(searchParams: String) {
    SearchContentManager.fetchResults(searchParams: searchParams){ [weak self] (resultArray) in
      
      guard resultArray != nil else {
        //call delegate for no results
        return
      }
      //unwrap these
      self?.resultsArray = resultArray!
      self?.delegate?.resultsDidLoad()
    }
  }
  
  func getResultsImages() {
    
    SearchContentManager.getResultsImages(resultsArray: resultsArray) {[weak self] (imageArray) in
      //does nothing
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
