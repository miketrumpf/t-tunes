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
  
  //  static func storyboardInstance() -> PostsViewController? {
//    let storyboard = UIStoryboard(name:
//      "PostsViewController", bundle: nil)
//    return storyboard.instantiateViewController(withIdentifier: VCNameConstants.posts) as? PostsViewController
//  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
  }
  
  func goToLyricsButtonTapped(_ cell: ResultsTableViewCell) {
    
  }
  
  
  @IBAction func searchButtonPressed(_ sender: Any) {
    //check for empty search box
    //need a loader
    
    
    //put this in delegate function once results come in
    setUpCustomTableViewCells()
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
    
    //each cell will pull from array of results
//    changeCellBackgroundColor(cell)
//    setUpCellButton(cell)
//    toggleCellViewSettings(cell)
//    DispatchQueue.main.async {
//      //cell.userProfileImageview.layoutIfNeeded()
//      cell.userProfileImageview.clipsToBounds = true
//      cell.userProfileImageview.layer.cornerRadius = cell.userProfileImageview.frame.height / 2
//    }
//    if challengeViewModel.challengeType == .pending {
//      if challengeViewModel.gameChallengesPendingArray.count > 0 {
//        updateCellInfo(cell, indexPath, challengeArray: challengeViewModel.gameChallengesPendingArray)
//      }
//    } else {
//      if challengeViewModel.gameChallengesPreviousArray.count > 0 {
//        updateCellInfo(cell, indexPath, challengeArray: challengeViewModel.gameChallengesPreviousArray)
//      }
//    }
//
    return cell
  }

  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    return challengeViewModel.numberOfRows()
    return 5
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    if challengeViewModel.challengeType == .pending {
//      timer?.invalidate()
//      challengeViewModel.challengeIndex = indexPath.row
//      updatePendingGameView(forRow: indexPath.row, self)
//    }
  }
  
  
  
}
