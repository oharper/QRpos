//
//  ViewController.swift
//  QRpos
//
//  Created by Owen Harper on 28/09/2017.
//  Copyright © 2017 Owen Harper. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

  
  //MARK Outlets
  @IBOutlet weak var newOrderButton: UIButton!
  @IBOutlet weak var closeTabButton: UIButton!
  @IBOutlet weak var currentEventLabel: UILabel!
  
  
  //MARK Variables
  var currentEvent: String?
  
  
  //MARK Actions
  @IBAction func newOrderPressed(_ sender: Any) {
    
    if(currentEvent != nil) {
      self.performSegue(withIdentifier: "initialToNewOrder", sender: nil)
    }
    
  }
  
  
  @IBAction func closeTabPressed(_ sender: Any) {
    
    if(currentEvent != nil) {
      self.performSegue(withIdentifier: "initialToCloseTab", sender: nil)
    }
    
  }
  
  
  //MARK ViewDidLoad
  override func viewDidLoad() {
    super.viewDidLoad()

    //Rounds the corners of the action buttons
    newOrderButton.layer.cornerRadius = 6
    newOrderButton.clipsToBounds = true
    closeTabButton.layer.cornerRadius = 6
    closeTabButton.clipsToBounds = true
    
    //API Get current event
    currentEvent = "IOD Debate 2017"
    
    //Set current event label
    currentEventLabel.text = currentEvent
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

