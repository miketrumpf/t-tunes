//
//  SearchScreenViewController.swift
//  TTunes
//
//  Created by Mike on 9/27/17.
//

import Foundation
import UIKit

class SearchScreenViewController: UIViewController, SearchViewModelDelegate, UITableViewDelegate, UITableViewDataSource, ResultsTableViewCellDelegate {
  

  @IBOutlet weak var searchTextField: UITextField!
  @IBOutlet weak var searchButton: UIButton!
  @IBOutlet weak var resultsTableView: UITableView!
  
  let searchViewModel = SearchViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    searchViewModel.delegate = self
  }
  
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
  }
  
  func goToLyricsButtonTapped(_ cell: ResultsTableViewCell) {
    
  }
  
  
  @IBAction func searchButtonPressed(_ sender: Any) {
    //check for empty search box
    //need a loader
    
    guard let searchParams = self.searchTextField.text, !searchParams.isEmpty else {
      let alertController = UIAlertController(title: "Error", message: "Please enter a search term", preferredStyle: .alert)
      let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
      alertController.addAction(okayAction)
      present(alertController, animated: true, completion: nil)
      return
    }
    
    searchViewModel.fetchResults(searchParams: searchParams)
    

  }
  func resultsDidLoad() {
    //put this in delegate function once results come in
    searchViewModel.getResultsImages()
    self.view.endEditing(true)
  }

  func imagesDidLoad() {
    setUpCustomTableViewCells()

  }
  
  func throwError() {
    let alertController = UIAlertController(title: "Error", message: "Something Went wrong.", preferredStyle: .alert)
    let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
    alertController.addAction(okayAction)
    present(alertController, animated: true, completion: nil)
  }

  
  //table view functions
  func setUpCustomTableViewCells() {
    resultsTableView.delegate = self
    resultsTableView.dataSource = self
    let cellNib = NibInstanceConstants.resultCell
    resultsTableView.register(cellNib, forCellReuseIdentifier: XibNameConstants.resultCell)
    self.resultsTableView.isHidden = false
    resultsTableView.reloadData()
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = resultsTableView.dequeueReusableCell(withIdentifier: XibNameConstants.resultCell) as! ResultsTableViewCell
    cell.delegate = self
    let currentResult = self.searchViewModel.resultsArray[indexPath.row]
    cell.artistNameLabel.text = "Artist: \(currentResult.artist)"
    cell.trackNameLabel.text = "Track: \(currentResult.track)"
    cell.albumNameLabel.text = "Album: \(currentResult.album)"
    if currentResult.image != nil {
      cell.albumImage.image = currentResult.image!
    }
    return cell
  }

  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    return challengeViewModel.numberOfRows()
    return self.searchViewModel.resultsArray.count
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let selection = self.searchViewModel.resultsArray[indexPath.row]
    navigateToLyricsScreen(song: selection.track, artist: selection.artist, image: selection.image!, url: selection.trackViewUrl)

    
  }
  
  func navigateToLyricsScreen(song: String, artist: String, image: UIImage, url: String) {
    let lyricsScreenStoryboard = StoryboardInstanceConstants.lyricsScreen
    let lyricsScreenViewController = lyricsScreenStoryboard.instantiateViewController(withIdentifier: VCNameConstants.lyrics) as! LyricsScreenViewController
    lyricsScreenViewController.artistName = artist
    lyricsScreenViewController.songName = song
    lyricsScreenViewController.albumImage = image
    lyricsScreenViewController.trackViewUrl = url
    present(lyricsScreenViewController, animated: true, completion: nil)
  }
  
  
}
