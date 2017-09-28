//
//  ContentItemModel.swift
//  TTunes
//
//  Created by Mike on 9/27/17.
//

import Foundation
struct ContentItemConstants {
  static let identifier = "trackId"
  static let cacheCreationDate = "cacheCreationDate"
  static let cacheExpirationDate = "cacheExpirationDate"
}

//class that user model, quiz model, and game model will inherit from
//this will allow a single cache manager that caches files based on unique identifier in one place, easily searchable when checking/retrieving cached files
class ContentItemModel : NSObject {
  
  var identifier: Int!
  var cacheCreationDate: Date!
  var cacheExpirationDate: Date!
  
  
  init?(dictionary: [String: AnyObject]) {
    
    guard let id = dictionary[ContentItemConstants.identifier] as? Int else {
      return nil
    }
    
    self.identifier = id
    self.cacheCreationDate = Date()
    var dayComponent = DateComponents()
    let calendar = Calendar.current
    dayComponent.day = 7
    self.cacheExpirationDate = (calendar as NSCalendar).date(byAdding: dayComponent, to: cacheCreationDate, options: NSCalendar.Options(rawValue: 0))!
  }
  
  
  func encodeWithEncoder(_ aCoder: NSCoder) {
    aCoder.encode(identifier, forKey: ContentItemConstants.identifier)
    aCoder.encode(cacheCreationDate, forKey: ContentItemConstants.cacheCreationDate)
    aCoder.encode(cacheExpirationDate, forKey: ContentItemConstants.cacheExpirationDate)
  }
  
  required init?(coder aDecoder: NSCoder) {
    guard let id = aDecoder.decodeObject(forKey: ContentItemConstants.identifier) as? Int else {
      return nil
    }
    identifier = id
    guard let creationDate = aDecoder.decodeObject(forKey: ContentItemConstants.cacheCreationDate) as? Date else {
      return nil
    }
    cacheCreationDate = creationDate
    guard let expirationDate = aDecoder.decodeObject(forKey: ContentItemConstants.cacheExpirationDate) as? Date else {
      return nil
    }
    cacheExpirationDate = expirationDate
  }
  
  func calculateExpirationDate(_ itemCreationDate: Date) ->  Date {
    var dayComponent = DateComponents()
    let calendar = Calendar.current
    dayComponent.day = 7
    let expirationDate = (calendar as NSCalendar).date(byAdding: dayComponent, to: itemCreationDate, options: NSCalendar.Options(rawValue: 0))!
    return expirationDate
  }
  
  
  
}


