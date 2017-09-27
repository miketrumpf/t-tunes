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
  static let track = "track"
  static let album = "album"
//  static let image = "image"
//  static let imageUrl = "imageUrl"
  
  
}

class ResultModel: ContentItemModel, NSCoding {
  
  var resultId: String
  var artist: String
  var track: String
  var album: String
//  var image: UIImage?
//  var imageUrl: URL?
  
  
  
  override init?(dictionary: [String: AnyObject]) {
    guard let result = dictionary[ResultConstants.resultId] as? String else {
      return nil
    }
    resultId = result
    
    guard let artistName = dictionary[ResultConstants.artist] as? String else {
      return nil
    }
    
    artist = artistName
    
    
    guard let trackName = dictionary[ResultConstants.track] as? String else {
      return nil
    }
    
    track = trackName
    
    guard let albumName = dictionary[ResultConstants.album] as? String else {
      return nil
    }
    
    album = albumName
    super.init(dictionary: dictionary)
  }
  
  
  func encode(with aCoder: NSCoder) {
    aCoder.encode(resultId, forKey: ResultConstants.resultId)
    aCoder.encode(artist, forKey: ResultConstants.artist)
    aCoder.encode(track, forKey: ResultConstants.track)
    aCoder.encode(album, forKey: ResultConstants.album)

    
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
    
    guard let trackName = aDecoder.decodeObject(forKey: ResultConstants.track) as? String else {
      return nil
    }
    
    track = trackName
    
    guard let albumName = aDecoder.decodeObject(forKey: ResultConstants.album) as? String else {
      return nil
    }
    
    album = albumName


    
    super.init(coder: aDecoder)
  }
  
}
