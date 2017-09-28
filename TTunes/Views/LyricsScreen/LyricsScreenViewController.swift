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
  var trackViewUrl = ""
  var albumImage = UIImage()
  let lyricsViewModel = LyricsViewModel()
  
  
  @IBOutlet weak var image: UIImageView!
  @IBOutlet weak var artistLabel: UILabel!
  @IBOutlet weak var trackLabel: UILabel!
  @IBOutlet weak var albumLabel: UILabel!
  
  
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
    image.image = albumImage
    artistLabel.text = artistName
    trackLabel.text = songName
    albumLabel.text = albumName
  }
  
  func throwError() {
    let alertController = UIAlertController(title: "Error", message: "Error accessing Lyrics for this song", preferredStyle: .alert)
    let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
    alertController.addAction(okayAction)
    present(alertController, animated: true, completion: nil)
  }

  
  @IBAction func backButtonPressed(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)

  }
  
  
  @IBAction func visitSongPage(_ sender: Any) {
    if let url = URL(string: trackViewUrl) {
      UIApplication.shared.open(url, options: [:])
    }

  }
  
 
  
  
  
}
