//
//  LyricsContentManager.swift
//  TTunes
//
//  Created by Mike on 9/27/17.
//

import Foundation
import UIKit


class LyricsContentManager: NSObject {
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
  
  static func fetchLyrics(song: String, artist: String, withCompletion completion: @escaping (String?) -> Void) {
    //    guard Reachability.connectedToNetwork() else {
    //      completion(nil)
    //      return
    //    }
    
    //    MainCacheManager.clearAllCachedResults()
    //    MainCacheManager.clearAllCachedGratifications()
    
    
    LyricsAPIManager.fetchLyricsWithCompletion(song: song, artist: artist, comp: { lyricString in
//      guard let results = contentArray, results.count > 0 else {
//        completion(nil)
//        return
//      }
      var lyrics = ""
      var urlString = ""
      //super hacky an ugly parsing of this response string.
      if let index = (lyricString?.range(of: "song = ")?.upperBound) {
        var afterEqualsTo = String(describing: lyricString!.substring(from: index))
        var dropFirst = String(afterEqualsTo.dropFirst())
        var droppedLast = String(dropFirst.dropLast(2))
        
        if let newIndex = (droppedLast.range(of: "lyrics':")?.upperBound) {
          var afterLyrics = String(droppedLast.substring(from: newIndex))
          
          if let newestIndex = (afterLyrics.range(of: "url")?.lowerBound) {
//            urlString = String(afterLyrics.substring(from: newestIndex))
            var cleanLyrics = String(afterLyrics.substring(to: newestIndex))
            lyrics = cleanLyrics
          }
        }
      }
      
      let noNewLines = lyrics.replacingOccurrences(of: "\\n", with: ", ")
      let noSlashes = noNewLines.replacingOccurrences(of: "\\", with: "")
      completion(noSlashes)
    })
    
  }
  
  static func getResultsImages(resultsArray: [ResultModel], withCompletion completion: @escaping ([UIImage]?) -> Void) {

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
