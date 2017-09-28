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

}
class LyricsViewModel: NSObject {
  var lyrics = String()
  weak var delegate: LyricsViewModelDelegate?
  
  
  //fetch Results based on search term. //will need to pass params
  func fetchLyrics(song: String, artist: String) {
    LyricsContentManager.fetchLyrics(song: song, artist: artist){ [weak self] (lyrics) in
      
      guard lyrics != nil else {
        //call delegate for no results
        return
      }
      //unwrap these
      self?.lyrics = lyrics!
      self?.delegate?.lyricsDidLoad()
    }
  }
  

  
  
  
}
