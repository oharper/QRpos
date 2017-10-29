//
//  QRViewController.swift
//  QRpos
//
//  Created by Owen Harper on 27/10/2017.
//  Copyright © 2017 Owen Harper. All rights reserved.
//

import UIKit

class QRViewController: UIViewController {

  //MARK Variables
  var currentOrder = Order()
  
  //MARK Actions
  @IBAction func backPressed(_ sender: Any) {
    performSegue(withIdentifier: "qrToPayment", sender: nil)
  }
  
  //PLACEHOLDER BUTTON
  @IBAction func qrButtonPressed(_ sender: Any) {
    performSegue(withIdentifier: "qrToConfirm", sender: nil)
  }
  
    //MARK ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

      //PLACEHOLDER DATA
      currentOrder.tabNumber = "2A"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  //MARK Segues
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if (segue.identifier == "qrToPayment") {
      let view : PaymentViewController = segue.destination as! PaymentViewController;
      view.currentOrder = currentOrder
    } else if (segue.identifier == "qrToConfirm") {
      let view : QRConfirmViewController = segue.destination as! QRConfirmViewController;
      view.currentOrder = currentOrder
  }
  }
  

}
