//
//  tunesApiConstants.swift
//  TTunes
//
//  Created by Mike on 9/27/17.
//

import Foundation

struct APIConstants {
//  static let newNowApiUrl = "/api/v1"
  //get artist url
//  "https://itunes.apple.com/search?term=tom+waits"
  static let itunesBaseUrl = "https://itunes.apple.com/search?term="
  static let lyricsBaseUrl = "http://lyrics.wikia.com/api.php?func=getSong&artist="
  static let andSongUrl = "&song="
  static let formatUrl = "&fmt=json"
  //get song and lyrics url
  //"http://lyrics.wikia.com/api.php?func=getSong&artist=Tom+Waits&song=new+coat+of+paint&fmt=json"
}
