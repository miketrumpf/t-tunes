//
//  LyricsApiManager.swift
//  TTunes
//
//  Created by Mike on 9/27/17.
//

import Foundation
import Alamofire


struct LyricsAPIConstants {
//  static let posts = "posts"
}

class LyricsAPIManager: NSObject {
//
//
  static func fetchLyricsWithCompletion(song: String, artist: String, comp: @escaping (String?) -> Void) {
    
    //join song and artist with + signs in separate variables
    
    let baseUrl = APIConstants.lyricsBaseUrl
    let songParams = song
    let songParamsArray = songParams.components(separatedBy: " ")
    let joinedSongParams = songParamsArray.joined(separator: "+")
    let artistParams = artist
    let artistParamsArray = artistParams.components(separatedBy: " ")
    let joinedArtistParams = artistParamsArray.joined(separator: "+")
    
//    let testString = "http://lyrics.wikia.com/api.php?func=getSong&artist=Tom+Waits&song=new+coat+of+paint&fmt=json"
//

    let urlString = baseUrl + joinedArtistParams + APIConstants.andSongUrl + joinedSongParams + APIConstants.formatUrl

    guard let lyricsUrl = URL(string: urlString) else {
      print("CAPI: contacts url failed")
      comp("")
      return
    }
    
    Alamofire.request(lyricsUrl, encoding: URLEncoding.default).responseString { response in
      guard let lyricsString = response.result.value as? String else {
        comp(nil)
        return
      }

      
      comp(lyricsString)
//      if let lyricDictArray = jsonDict["posts"] as? [[String: AnyObject]], postDictArray.count > 0, let gratificationDictArray = jsonDict["gratification"] as? [String: AnyObject] {
//
//        comp(postDictArray, gratificationDictArray)
//      } else {
//        comp(nil)
//      }
    }
  }

  
  
}
