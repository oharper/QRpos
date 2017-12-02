//
//  ViewController.swift
//  QRpos
//
//  Created by Owen Harper on 28/09/2017.
//  Copyright © 2017 Owen Harper. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class InitialViewController: UIViewController {

  //MARK Outlets
  @IBOutlet weak var newOrderButton: UIButton!
  @IBOutlet weak var closeTabButton: UIButton!
  @IBOutlet weak var openOrdersButton: UIButton!
  @IBOutlet weak var tableServiceSwitch: UISwitch!
  @IBOutlet weak var iPadLabel: UILabel!
  
  @IBOutlet weak var currentEventButton: UIButton!
  
  //MARK Actions
  
  //New Order Button Segue
  @IBAction func newOrderPressed(_ sender: Any) {
      self.performSegue(withIdentifier: "initialToNewOrder", sender: nil)
  }
  
  //Close Tab Button Segue
  @IBAction func closeTabPressed(_ sender: Any) {
      self.performSegue(withIdentifier: "initialToCloseTab", sender: nil)
  }
  
  //Table Service Switch Actions
  @IBAction func tableServiceSwitched(_ sender: Any) {
    if tableServiceSwitch.isOn {
      tableService = true
      iPadLabel.text = "Table Service iPad"
    } else {
      tableService = false
      iPadLabel.text = "Bar iPad"
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
    openOrdersButton.layer.cornerRadius = 6
    openOrdersButton.clipsToBounds = true
    
    //Set current event label
    currentEventButton.setTitle(currentEvent, for: .normal)
    
    if tableService {
      tableServiceSwitch.setOn(true, animated: true)
    }
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  
}

