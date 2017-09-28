//
//  Viewidentifiers.swift
//  TTunes
//
//  Created by Mike on 9/27/17.
//

import Foundation
import UIKit
//view controller constants
struct VCNameConstants {
  static let launch = "Launch"
  static let search = "searchScreenVC"
  static let lyrics = "lyricsViewVC"
}

struct StoryboardInstanceConstants {
  static let launch = UIStoryboard(name: "LaunchViewController", bundle: nil)
  static let searchView = UIStoryboard(name: "SearchScreenViewController", bundle: nil)
  static let lyricsScreen = UIStoryboard(name: "LyricsScreenViewController", bundle: nil)
  
}

struct NibInstanceConstants {
  static let resultCell = UINib.init(nibName: "ResultsTableViewCell", bundle: nil)

}

struct XibNameConstants {
  static let resultCell = "ResultsTableViewCell"

}
