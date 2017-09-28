//
//  SearchAPIManager.swift
//  TTunes
//
//  Created by Mike on 9/27/17.
//

import Foundation
import Alamofire


class SearchAPIManager: NSObject {
  //
  //
  static func fetchResultsWithCompletion(searchParams: String, comp: @escaping ([[String: AnyObject]]?) -> Void) {
      let baseUrl = APIConstants.itunesBaseUrl
    
      //if user gave multiple params join them with a + to fit api call format
      let params = searchParams
      let paramsArray = params.components(separatedBy: " ")
      let joinedParams = paramsArray.joined(separator: "+")
      let searchUrlString = baseUrl + joinedParams
  
      guard let searchUrl = URL(string: searchUrlString) else {
        print("CAPI: search url failed")
        comp([[String: AnyObject]]())
        return
      }
  
      Alamofire.request(searchUrl, encoding: URLEncoding.default).responseJSON { response in
        guard let jsonDict = response.result.value as? [String: AnyObject] else {
          comp(nil)
          return
        }
        
        
        if let resultDictArray = jsonDict.first?.value as? [[String: AnyObject]], resultDictArray.count > 0 {

          comp(resultDictArray)
        } else {
          comp(nil)
        }
      }
    }
  
    static func fetchImageWithCompletion(_ result: ResultModel, comp: @escaping (UIImage?) -> Void) {
      guard let url = result.imageUrl else {
        comp(nil)
        return
      }

  
      //    URLCache.shared.removeAllCachedResponses()
      MainCacheManager.clearAllCachedResults()
      Alamofire.request(url, encoding: URLEncoding.default).responseJSON { response in
        guard let imageData = response.data else {
          comp(nil)
          return
        }
        guard let image = UIImage(data: imageData) else {
          comp(nil)
          return
        }
        comp(image)
      }
    }

  
  
}
