//
//  SearchContentManager.swift
//  TTunes
//
//  Created by Mike on 9/27/17.
//

import Foundation
import UIKit


class SearchContentManager: NSObject {
  
  static func fetchResults(searchParams: String, withCompletion completion: @escaping ([ResultModel]?) -> Void) {

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
    let resultArray = resultsArray
    var imageArray = [UIImage]()
    //for every result hit api manager to download and cache album image
    for resultModel in resultArray {
      SearchAPIManager.fetchImageWithCompletion(resultModel) { (image) in
        resultModel.image = image
        let newResultFilePath = MainCacheManager.cacheLocationForObject(resultModel, itemType: ItemCacheType.result)
        MainCacheManager.cacheInformationForItem(resultModel, filePath: newResultFilePath)
        //unwrap? fix
        imageArray.append(image!)
        completion(imageArray)
      }
    }

  }
  

  
  
  
}
