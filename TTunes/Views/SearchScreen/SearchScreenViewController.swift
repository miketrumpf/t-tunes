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
    styleButton()
  }
  
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
  }
  
  func goToLyricsButtonTapped(_ cell: ResultsTableViewCell) {
    
  }
  
  
  @IBAction func searchButtonPressed(_ sender: Any) {
    //check for empty search box
    
    guard let searchParams = self.searchTextField.text, !searchParams.isEmpty else {
      let alertController = UIAlertController(title: "Error", message: "Please enter a search term", preferredStyle: .alert)
      let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
      alertController.addAction(okayAction)
      present(alertController, animated: true, completion: nil)
      return
    }
    
    searchViewModel.fetchResults(searchParams: searchParams)
    

  }
  //if we got results hide keyboard and go get images
  func resultsDidLoad() {
    searchViewModel.getResultsImages()
    self.view.endEditing(true)
  }
  
  //update table
  func imagesDidLoad() {
    setUpCustomTableViewCells()

  }
  //delegate function if problem with their search term
  func throwError() {
    let alertController = UIAlertController(title: "Error", message: "Something Went wrong. Please try a different search term.", preferredStyle: .alert)
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
  
  //setting up cells
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
  //100 is height of images
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
  
  //user selected row
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let selection = self.searchViewModel.resultsArray[indexPath.row]
    navigateToLyricsScreen(song: selection.track, artist: selection.artist, image: selection.image!, url: selection.trackViewUrl)
  }
  //go to lyrics screen, pass data that we have
  func navigateToLyricsScreen(song: String, artist: String, image: UIImage, url: String) {
    let lyricsScreenStoryboard = StoryboardInstanceConstants.lyricsScreen
    let lyricsScreenViewController = lyricsScreenStoryboard.instantiateViewController(withIdentifier: VCNameConstants.lyrics) as! LyricsScreenViewController
    lyricsScreenViewController.artistName = artist
    lyricsScreenViewController.songName = song
    lyricsScreenViewController.albumImage = image
    lyricsScreenViewController.trackViewUrl = url
    present(lyricsScreenViewController, animated: true, completion: nil)
  }
  //button styling
  func styleButton() {
    searchButton.backgroundColor = UIColor.lightGray
    searchButton.layer.shadowColor = UIColor.black.cgColor
    searchButton.layer.shadowOffset.height = 5
    searchButton.layer.shadowOpacity = 0.6
    searchButton.layer.shadowRadius = 10
    searchButton.layer.cornerRadius = 20
    searchButton.layer.borderColor = UIColor.gray.cgColor
  }
  
  
}
