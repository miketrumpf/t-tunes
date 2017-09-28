//
//  ResultsModel.swift
//  TTunes
//
//  Created by Mike on 9/27/17.
//

import Foundation
import UIKit

struct ResultConstants {
  static let resultId = "trackId"
  static let artist = "artistName"
  static let track = "trackName"
  static let album = "collectionName"
  static let image = "image"
  static let imageUrl = "artworkUrl100"
  
  
}

class ResultModel: ContentItemModel, NSCoding {
  
  var resultId: Int
  var artist: String
  var track: String
  var album: String
  var image: UIImage?
  var imageUrl: URL?
  
  
  
  override init?(dictionary: [String: AnyObject]) {
    guard let result = dictionary[ResultConstants.resultId] as? Int else {
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
    
    if let imageString = dictionary[ResultConstants.imageUrl] as? String {
      self.imageUrl = URL(string: imageString)
    }
    
    super.init(dictionary: dictionary)
  }
  
  
  func encode(with aCoder: NSCoder) {
    aCoder.encode(resultId, forKey: ResultConstants.resultId)
    aCoder.encode(artist, forKey: ResultConstants.artist)
    aCoder.encode(track, forKey: ResultConstants.track)
    aCoder.encode(album, forKey: ResultConstants.album)
    aCoder.encode(imageUrl, forKey: ResultConstants.imageUrl)
    aCoder.encode(image, forKey: ResultConstants.image)
    
    super.encodeWithEncoder(aCoder)
  }
  
  required init?(coder aDecoder: NSCoder) {
    guard let result = aDecoder.decodeObject(forKey: ResultConstants.resultId) as? Int else {
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

    if let imageURL = aDecoder.decodeObject(forKey: ResultConstants.imageUrl) as? URL {
      imageUrl = imageURL
    }
    
    if let imageRaw = aDecoder.decodeObject(forKey: ResultConstants.image) as? UIImage {
      image = imageRaw
    }

    
    super.init(coder: aDecoder)
  }
  
}
