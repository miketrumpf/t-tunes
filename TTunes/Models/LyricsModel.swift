//
//  LyricsModel.swift
//  TTunes
//
//  Created by Mike on 9/27/17.
//

import Foundation
import UIKit


struct LyricsConstants {
  //song info will carry over from selected cell
  static let lyricId = "id"
  static let lyricText = "lyrics"
  
}

class LyricsModel: ContentItemModel, NSCoding {
  
  var lyricId: String
  var lyricText: String
  
  
  
  
  
  override init?(dictionary: [String: AnyObject]) {
    guard let lyric = dictionary[LyricsConstants.lyricId] as? String else {
      return nil
    }
    lyricId = lyric
    
    guard let songLyrics = dictionary[LyricsConstants.lyricText] as? String else {
      return nil
    }
    
    lyricText = songLyrics

    
    super.init(dictionary: dictionary)
  }
  
  
  func encode(with aCoder: NSCoder) {
    aCoder.encode(lyricId, forKey: LyricsConstants.lyricId)
    aCoder.encode(lyricText, forKey: LyricsConstants.lyricText)
    
    
    super.encodeWithEncoder(aCoder)
  }
  
  required init?(coder aDecoder: NSCoder) {
   
    guard let lyric = aDecoder.decodeObject(forKey: LyricsConstants.lyricId) as? String else {
      return nil
    }
    lyricId = lyric
    
    guard let songLyrics = aDecoder.decodeObject(forKey: LyricsConstants.lyricText) as? String else {
      return nil
    }
    lyricText = songLyrics

    
    
    
    super.init(coder: aDecoder)
  }
  
}
