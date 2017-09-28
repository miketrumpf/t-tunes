//
//  LyricsScreenViewController.swift
//  TTunes
//
//  Created by Mike on 9/27/17.
//

import Foundation
import UIKit

class LyricsScreenViewController: UIViewController, LyricsViewModelDelegate {
  
  @IBOutlet weak var lyricLabel: UILabel!
  
  var albumName = ""
  var songName = ""
  var artistName = ""
  var albumImage = UIImage()
  let lyricsViewModel = LyricsViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    lyricsViewModel.delegate = self
    lyricsViewModel.fetchLyrics(song: songName, artist: artistName)
    
    
  }
  
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
  }
  

  
  

  func lyricsDidLoad() {
    //put this in delegate function once results come in
    lyricLabel.text = lyricsViewModel.lyrics
//    searchViewModel.getResultsImages()
  }
  

  
  
 
  
  
  
}
