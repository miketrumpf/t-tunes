//
//  SearchViewModel.swift
//  TTunes
//
//  Created by Mike on 9/27/17.
//

import Foundation
import UIKit


protocol SearchViewModelDelegate: class {
//  func postsDidLoad()
//  func noPosts()
//  func imagesDidLoad()
//  func htmlDidLoad()
}
class SearchViewModel: NSObject {
//  var postsArray = [PostModel]()
//  weak var delegate: PostViewModelDelegate?

  
  //fetch Results based on search term. //will need to pass params
  func fetchResults() {
    
//    PostContentManager.loadPosts { [weak self] (postArray) in
//      guard postArray != nil else {
//        //call delegate for custom no more videos message
//        return
//      }
//      //unwrap this
//      self?.postsArray = postArray!
//      self?.delegate?.postsDidLoad()
//      //call delegate method in view to do something with the videos, loading active gif
//    }
  }
  
 
  func resultsDidLoad() {
    //checks if the images have already been added to the games from the previously cached games
//    guard postIndex <= postsArray.count - 1 else {
//      delegate?.imagesDidLoad()
//      print("CHECKING PUSH TOKEN!!!!!!")
//      PostContentManager.checkPushToken()
//      return
//    }
//    let post = postsArray[postIndex]

  }

  
  
  
}
