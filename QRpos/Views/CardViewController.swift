//
//  CardViewController.swift
//  QRpos
//
//  Created by Owen Harper on 27/10/2017.
//  Copyright © 2017 Owen Harper. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {

  //MARK Outlets
  @IBOutlet weak var totalLabel: UILabel!
  
  //MARK Variables
  var order: [OrderItem]? = []
  var subTotal: Double = 0
  
  //MARK Actions
  @IBAction func backPressed(_ sender: Any) {
    performSegue(withIdentifier: "cardToPayment", sender: nil)
    
  }
  
  @IBAction func donePressed(_ sender: Any) {
  }
  
  
  override func viewDidLoad() {
        super.viewDidLoad()
    
      totalLabel.text = "£" + String(format: "%.2f", subTotal)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if (segue.identifier == "cardToPayment") {
      let view : PaymentViewController = segue.destination as! PaymentViewController;
      view.order = order
      view.subTotal = subTotal
    }
  }
    
    

}
