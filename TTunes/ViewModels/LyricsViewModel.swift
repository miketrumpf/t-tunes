//
//  LyricsViewModel.swift
//  TTunes
//
//  Created by Mike on 9/27/17.
//

import Foundation
import UIKit


protocol LyricsViewModelDelegate: class {
  func lyricsDidLoad()
  func throwError()

}
class LyricsViewModel: NSObject {
  var lyrics = String()
  weak var delegate: LyricsViewModelDelegate?
  
  
  //fetch Results based on search term/s.
  func fetchLyrics(song: String, artist: String) {
    LyricsContentManager.fetchLyrics(song: song, artist: artist){ [weak self] (lyrics) in
      
      //will be an empty string if there was an issue with parsing the json response string
      guard lyrics != "" else {
        //call delegate for no results
        self?.delegate?.throwError()
        return
      }
      
      //unwrap these
      self?.lyrics = lyrics!
      self?.delegate?.lyricsDidLoad()
    }
  }
  

  
  
  
}
