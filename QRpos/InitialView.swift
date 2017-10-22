//
//  ViewController.swift
//  QRpos
//
//  Created by Owen Harper on 28/09/2017.
//  Copyright © 2017 Owen Harper. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var newOrderButton: UIButton!
  @IBOutlet weak var closeTabButton: UIButton!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    //Rounds the corners of the action buttons
    newOrderButton.layer.cornerRadius = 6
    newOrderButton.clipsToBounds = true
    closeTabButton.layer.cornerRadius = 6
    closeTabButton.clipsToBounds = true
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

