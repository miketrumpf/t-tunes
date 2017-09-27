//
//  Viewidentifiers.swift
//  TTunes
//
//  Created by Mike on 9/27/17.
//

import Foundation
import UIKit

struct VCNameConstants {
  static let launch = "Launch"
  static let search = "searchScreenVC"
  static let lyrics = "lyricsViewVC"
}

struct StoryboardInstanceConstants {
  static let launch = UIStoryboard(name: "LaunchViewController", bundle: nil)
  static let searchView = UIStoryboard(name: "SearchViewController", bundle: nil)
  static let lyricsScreen = UIStoryboard(name: "LyricsViewController", bundle: nil)
  
}

struct NibInstanceConstants {
  //  static let favoriteCell = UINib.init(nibName: "FavoritesTableViewCell", bundle: nil)
  
}

struct XibNameConstants {
  //  static let favoriteCell = "FavoritesTableViewCell"
  
}
