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
  var order: [OrderItem]? = []
  var subTotal: Double = 0
  
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
  
  override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if (segue.identifier == "paymentToNewOrder") {
      let view : NewOrderViewController = segue.destination as! NewOrderViewController;
      view.order = order
      view.subTotal = subTotal
    } else if (segue.identifier == "paymentToQR") {
      let view: QRViewController = segue.destination as! QRViewController;
      view.order = order
      view.subTotal = subTotal
    } else if (segue.identifier == "paymentToCash") {
      let view: CashViewController = segue.destination as! CashViewController;
      view.order = order
      view.subTotal = subTotal
    } else if (segue.identifier == "paymentToCard") {
      let view: CardViewController = segue.destination as! CardViewController;
      view.order = order
      view.subTotal = subTotal
    }
    
  }
  

}
