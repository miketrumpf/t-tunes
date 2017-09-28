//
//  ResultsTableViewCell.swift
//  TTunes
//
//  Created by Mike on 9/27/17.
//

import UIKit

protocol ResultsTableViewCellDelegate: class {
    func goToLyricsButtonTapped(_ cell: ResultsTableViewCell)
}

class ResultsTableViewCell: UITableViewCell {

  //outlets
  @IBOutlet weak var albumImage: UIImageView!
  @IBOutlet weak var artistNameLabel: UILabel!
  @IBOutlet weak var albumNameLabel: UILabel!
  @IBOutlet weak var trackNameLabel: UILabel!
  
  
  weak var delegate: ResultsTableViewCellDelegate?
  weak var currentResult: ResultModel?
  
  
}

