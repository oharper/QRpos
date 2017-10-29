//
//  PaymentViewController.swift
//  QRpos
//
//  Created by Owen Harper on 26/10/2017.
//  Copyright © 2017 Owen Harper. All rights reserved.
//

import UIKit

class PaymentViewController: UIViewController {

  //MARK Variables
  var currentOrder = Order()
  
  //MARK Actions
  @IBAction func backgroundPressed(_ sender: Any) {
    performSegue(withIdentifier: "paymentToNewOrder", sender: nil)
  }
  
  @IBAction func tabPressed(_ sender: Any) {
    performSegue(withIdentifier: "paymentToQR", sender: nil)
  }
  
  @IBAction func cardPressed(_ sender: Any) {
    performSegue(withIdentifier: "paymentToCard", sender: nil)
  }
  
  @IBAction func cashPressed(_ sender: Any) {
    performSegue(withIdentifier: "paymentToCash", sender: nil)
  }
  
  //MARK ViewDidLoad
  override func viewDidLoad() {
        super.viewDidLoad()
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
  
  //MARK Segues
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if (segue.identifier == "paymentToNewOrder") {
      let view : NewOrderViewController = segue.destination as! NewOrderViewController;
      view.currentOrder = currentOrder
    } else if (segue.identifier == "paymentToQR") {
      let view: QRViewController = segue.destination as! QRViewController;
      view.currentOrder = currentOrder
    } else if (segue.identifier == "paymentToCash") {
      let view: CashViewController = segue.destination as! CashViewController;
      view.currentOrder = currentOrder
    } else if (segue.identifier == "paymentToCard") {
      let view: CardViewController = segue.destination as! CardViewController;
      view.currentOrder = currentOrder
    }
  }
  

}
