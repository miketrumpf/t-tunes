//
//  MainCacheManager.swift
//  TTunes
//
//  Created by Mike on 9/27/17.
//

import Foundation
enum ItemStatus {
  case expired
  case valid
  case notFound
}

enum ItemCacheType: String {
  case result = "Results"
  case lyrics = "Lyrics"
  
}

struct MainCacheManagerConstants {
  static let searchPaths = NSString(string: (NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true))[0])
}

class MainCacheManager : NSObject {
  
  fileprivate typealias Constants = MainCacheManagerConstants
  
  //filepath methods
  static func cacheLocationForItemType(_ itemType: ItemCacheType) -> String {
    let itemDirectoryString = itemType.rawValue
    let itemTypeFeedsDirectory = Constants.searchPaths.appendingPathComponent(itemDirectoryString)
    if !(FileManager.default.fileExists(atPath: itemTypeFeedsDirectory)) {
      do {
        try (FileManager.default).createDirectory(atPath: itemTypeFeedsDirectory, withIntermediateDirectories: true, attributes: nil)
      } catch let error as NSError {
        debugPrint(error.localizedDescription)
      }
    }
    return itemTypeFeedsDirectory
  }
  
  static func cacheLocationForObject(_ contentItem: ContentItemModel, itemType: ItemCacheType) -> String {
    let itemFeedsDirectory = cacheLocationForItemType(itemType)
    let itemDirectory = (itemFeedsDirectory as NSString).appendingPathComponent("\(contentItem.identifier!).cache")
    if !(FileManager.default.fileExists(atPath: itemDirectory)) {
      do {
        try (FileManager.default).createDirectory(atPath: itemDirectory, withIntermediateDirectories: true, attributes: nil)
      } catch let error as NSError {
        print(error.localizedDescription)
      }
    }
    return itemDirectory
  }
  
  //check if object is expired
  static func cacheStatusForObject(_ contentItem: ContentItemModel) -> (ItemStatus) {
    let distanceBetweenDates = contentItem.cacheExpirationDate.timeIntervalSince(contentItem.cacheCreationDate as Date)
    if distanceBetweenDates > 0 {
      return .valid
    } else {
      return .expired
    }
  }
  
  //removed content item argument, passing directory string instead so that doesn't need second argument for ItemType
  static func clearCacheForObject(_ directoryString: String) {
    let fileManager = FileManager.default
    let directory = directoryString
    do {
      try fileManager.removeItem(atPath: directory)
    } catch let error as NSError {
      print(error.localizedDescription)
    }
  }
  
  //cache object in directory
  static func cacheInformationForItem(_ contentItem: ContentItemModel, filePath: String) {
    clearCacheForObject(filePath)
    let fileName = filePath
    NSKeyedArchiver.archiveRootObject(contentItem, toFile: fileName)
  }
  
  //remove contentItem and itemType arguments and replace with just file path string argument?
  static func fetchCachedContentItemWithCompletion(_ contentItem: ContentItemModel, itemType: ItemCacheType, completion:(ContentItemModel?) -> Void) {
    //unwrap
    let fileName = ("\(contentItem.identifier!)" as NSString)
    let filePath = (cacheLocationForObject(contentItem, itemType: itemType) as NSString).appendingPathComponent("\(fileName).cache")
    let cachedContentItem = NSKeyedUnarchiver.unarchiveObject(withFile: filePath)
    let item = cachedContentItem as? ContentItemModel
    completion(item)
  }
  
  //access item type directory, add each item in
  static func fetchCachedResults(_ itemType: ItemCacheType) -> [ResultModel] {
    var resultsArray = [ResultModel]()
    let resultDirectory = MainCacheManager.cacheLocationForItemType(itemType)
    let fileManager = FileManager.default
    if let subPaths = fileManager.subpaths(atPath: resultDirectory) {
      for path in subPaths {
        if path != ".DS_Store" {
          let cachedResultPath = (resultDirectory as NSString).appendingPathComponent(path)
          let item = NSKeyedUnarchiver.unarchiveObject(withFile: cachedResultPath)
          if let cachedResult = item as? ResultModel {
            resultsArray.append(cachedResult)
          }
        }
      }
    }
    return resultsArray
  }
  
  

  static func clearAllCachedResults() {
    let cachedResultsArray = MainCacheManager.fetchCachedResults(ItemCacheType.result)
    for result in cachedResultsArray {
      let filePath = MainCacheManager.cacheLocationForObject(result, itemType: ItemCacheType.result)
      MainCacheManager.clearCacheForObject(filePath)
    }
  }
  

  
  
  
  
}
