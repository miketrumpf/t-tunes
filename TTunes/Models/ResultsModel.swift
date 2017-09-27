//
//  ResultsModel.swift
//  TTunes
//
//  Created by Mike on 9/27/17.
//

import Foundation
import UIKit

struct ResultConstants {
  static let resultId = "id"
  static let artist = "artist"
  static let song = "song"

  
  //  static let timesShared = "times_shared"
  
  
  
}

class ResultModel: ContentItemModel, NSCoding {
  
  var resultId: String
  var artist: String
  var song: String
  
  
  
  
  
  override init?(dictionary: [String: AnyObject]) {
    guard let result = dictionary[ResultConstants.resultId] as? String else {
      return nil
    }
    resultId = result
    
    guard let artistName = dictionary[ResultConstants.artist] as? String else {
      return nil
    }
    
    artist = artistName
    
    
    guard let songName = dictionary[ResultConstants.song] as? String else {
      return nil
    }
    
    song = songName
    
    super.init(dictionary: dictionary)
  }
  
  
  func encode(with aCoder: NSCoder) {
    aCoder.encode(resultId, forKey: ResultConstants.resultId)
    aCoder.encode(artist, forKey: ResultConstants.artist)
    aCoder.encode(song, forKey: ResultConstants.song)

    
    super.encodeWithEncoder(aCoder)
  }
  
  required init?(coder aDecoder: NSCoder) {
    guard let result = aDecoder.decodeObject(forKey: ResultConstants.resultId) as? String else {
      return nil
    }
    resultId = result
    
    guard let artistName = aDecoder.decodeObject(forKey: ResultConstants.artist) as? String else {
      return nil
    }
    artist = artistName
    
    guard let songName = aDecoder.decodeObject(forKey: ResultConstants.song) as? String else {
      return nil
    }
    
    song = songName


    
    super.init(coder: aDecoder)
  }
  
}
