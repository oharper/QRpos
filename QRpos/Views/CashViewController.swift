//
//  CashViewController.swift
//  QRpos
//
//  Created by Owen Harper on 27/10/2017.
//  Copyright © 2017 Owen Harper. All rights reserved.
//

import UIKit

class CashViewController: UIViewController {
  
  //MARK Outlets
  @IBOutlet weak var totalLabel: UILabel!
  @IBOutlet weak var changeLabel: UILabel!
  @IBOutlet weak var changeTextField: UITextField!
  
  //MARK Variables
  var currentOrder = Order()
  
  //MARK Actions
  @IBAction func calculatePressed(_ sender: Any) {
  }
  
  @IBAction func backButtonPressed(_ sender: Any) {
    performSegue(withIdentifier: "cashToPayment", sender: nil)
  }
  
  @IBAction func donePressed(_ sender: Any) {
    if tableService {
    //1. Create the alert controller.
    let alert = UIAlertController(title: "Enter Table", message: "Please enter a table number for delivery of order.", preferredStyle: .alert)
    //2. Add the text field. You can configure it however you need.
    alert.addTextField { (textField) in
      textField.keyboardType = UIKeyboardType.default
      textField.autocapitalizationType = .words
      textField.placeholder = "Table"
      textField.text = ""
    }
    // 3. Grab the value from the text field, and print it when the user clicks OK.
    alert.addAction(UIAlertAction(title: "Confirm Table", style: .default, handler: { [weak alert] (_) in
      self.currentOrder.deliveryTable = (alert?.textFields![0].text)!
      self.currentOrder.orderStatus = "Awaiting Delivery"
      
      //API call to add order to database
      
      self.performSegue(withIdentifier: "cashToInitial", sender: nil)
    }))
    // 4. Present the alert.
    self.present(alert, animated: true, completion: nil)
  }
    
    //API call to add order to database
    
    self.performSegue(withIdentifier: "cashToInitial", sender: nil)
  }
  
  //MARK ViewDidLoad
  override func viewDidLoad() {
        super.viewDidLoad()
    
    //Sets the initial label for total
    totalLabel.text = "£" + String(format: "%.2f", currentOrder.total)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
  
  //MARK Segues
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if (segue.identifier == "cashToPayment") {
      let view : PaymentViewController = segue.destination as! PaymentViewController;
      view.currentOrder = currentOrder
    }
  }

  
}
