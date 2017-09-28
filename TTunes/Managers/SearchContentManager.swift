//
//  SearchContentManager.swift
//  TTunes
//
//  Created by Mike on 9/27/17.
//

import Foundation
import UIKit


class SearchContentManager: NSObject {
  
  //access item type directory, add each item in
//  func fetchCachedPosts(_ itemType: ItemCacheType) -> Array<PostModel> {
//    var postsArray = Array<PostModel>()
//    //hardcoding item type as was receiving error
//    let postDirectory = MainCacheManager.cacheLocationForItemType(ItemCacheType.postHomePage)
//    let fileManager = FileManager.default
//    if let subPaths = fileManager.subpaths(atPath: postDirectory) {
//      for path in subPaths {
//        if path != ".DS_Store" {
//          let cachedPostPath = (postDirectory as NSString).appendingPathComponent(path)
//          let item = NSKeyedUnarchiver.unarchiveObject(withFile: cachedPostPath)
//          if let cachedPost = item as? PostModel {
//            postsArray.append(cachedPost)
//          }
//        }
//      }
//    }
//
//    //    postsArray.sorted({ $0.position > $1.position })
//    return postsArray.sorted(by: { $0.position > $1.position })
//  }
  

//  func isPostCachePresent(_ contentItem: ContentItemModel, itemType: ItemCacheType) -> Bool {
//    let postArray = fetchCachedPosts(itemType)
//    let isPresent = false
//    if postArray.count > 0 {
//      for post in postArray {
//        if post.identifier == contentItem.identifier {
//          return true
//        }
//      }
//    }
//    return isPresent
//  }
  
  static func fetchResults(searchParams: String, withCompletion completion: @escaping ([ResultModel]?) -> Void) {
    //    guard Reachability.connectedToNetwork() else {
    //      completion(nil)
    //      return
    //    }
    
//    MainCacheManager.clearAllCachedResults()
//    MainCacheManager.clearAllCachedGratifications()
    
    
    SearchAPIManager.fetchResultsWithCompletion(searchParams: searchParams, comp: { contentArray in
      guard let results = contentArray, results.count > 0 else {
        completion(nil)
        return
      }
      
      
      
      var resultArray = [ResultModel]()
      for resultDict in results {
        if let result = ResultModel(dictionary: resultDict) {
          let newResultFilePath = MainCacheManager.cacheLocationForObject(result, itemType: ItemCacheType.result)
          MainCacheManager.cacheInformationForItem(result, filePath: newResultFilePath)
          resultArray.append(result)
        }
      }
      completion(resultArray)
    })
  }
  
  static func getResultsImages(resultsArray: [ResultModel], withCompletion completion: @escaping ([UIImage]?) -> Void) {
    //    VideoAPIManager.fetchEspressoVideosWithCompletion(comp: { contentArray in
    //      guard let videos = contentArray, videos.count > 0 else {
    //        completion(nil)
    //        return
    //      }
    let resultArray = resultsArray
    var imageArray = [UIImage]()

    for resultModel in resultArray {
      SearchAPIManager.fetchImageWithCompletion(resultModel) { (image) in
        resultModel.image = image
        let newResultFilePath = MainCacheManager.cacheLocationForObject(resultModel, itemType: ItemCacheType.result)
        MainCacheManager.cacheInformationForItem(resultModel, filePath: newResultFilePath)
        //unwrap?
        imageArray.append(image!)
        completion(imageArray)
      }
//      completion(imageArray)
    }
//    completion(imageArray)

  }
  

  
  
  
}
