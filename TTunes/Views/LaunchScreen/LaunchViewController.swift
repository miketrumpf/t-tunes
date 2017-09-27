//
//  LaunchViewController.swift
//  TTunes
//
//  Created by Mike on 9/27/17.
//

import Foundation
import UIKit


class LaunchViewController: UIViewController {
  

//  @IBOutlet weak var anyLogo: UIImageView!
  

  static func storyboardInstance() -> LaunchViewController? {
    
    let storyboard = UIStoryboard(name:
      "LaunchViewController", bundle: nil)
    return storyboard.instantiateViewController(withIdentifier: VCNameConstants.launch) as? LaunchViewController
  }
  
  override func viewDidLoad() {
    
    super.viewDidLoad()

      
  }
  
  override func viewDidAppear(_ animated: Bool) {
    
  }
  

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    //fade in logo
    navigateToMainScreen()
  }
  
  override func viewDidLayoutSubviews() {
    
  }
  

  
  func navigateToMainScreen() {

    let searchScreenStoryboard = StoryboardInstanceConstants.searchView
    let searchScreenViewController = searchScreenStoryboard.instantiateViewController(withIdentifier: VCNameConstants.search)

    navigationController?.pushViewController(searchScreenViewController, animated: false)
  }
  
  

  



  

 

  
}
