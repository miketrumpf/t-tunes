//
//  LyricsApiManager.swift
//  TTunes
//
//  Created by Mike on 9/27/17.
//

import Foundation
import Alamofire




class LyricsAPIManager: NSObject {

  static func fetchLyricsWithCompletion(song: String, artist: String, comp: @escaping (String?) -> Void) {
    
    //join song and artist with + signs in separate variables. not very dry
    let baseUrl = APIConstants.lyricsBaseUrl
    let songParams = song
    let songParamsArray = songParams.components(separatedBy: " ")
    let joinedSongParams = songParamsArray.joined(separator: "+")
    let artistParams = artist
    let artistParamsArray = artistParams.components(separatedBy: " ")
    let joinedArtistParams = artistParamsArray.joined(separator: "+")
    //build string
    let urlString = baseUrl + joinedArtistParams + APIConstants.andSongUrl + joinedSongParams + APIConstants.formatUrl
    
    //create url
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

      //pass response string to the manager
      comp(lyricsString)

    }
  }

  
  
}
