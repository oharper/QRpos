//
//  QRConfirmViewController.swift
//  QRpos
//
//  Created by Owen Harper on 27/10/2017.
//  Copyright © 2017 Owen Harper. All rights reserved.
//

import UIKit

class QRConfirmViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  //MARK Outlets
  @IBOutlet weak var orderTable: UITableView!
  @IBOutlet weak var totalLabel: UILabel!
  
  //MARK Variables
  var order: [OrderItem]? = []
  var subTotal: Double = 0
  
  //MARK Actions
  @IBAction func backPressed(_ sender: Any) {
    performSegue(withIdentifier: "qrConfirmToQRScan", sender: nil)
  }
  
  @IBAction func donePressed(_ sender: Any) {
    
  }
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      self.orderTable.delegate = self
      self.orderTable.dataSource = self
      
      totalLabel.text = "Total: £" + String(format: "%.2f", subTotal)
      
    }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return (order?.count)!
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath) as! OrderCell
    cell.name.text = order![indexPath.row].drink.name
    cell.itemPrice.text = "£" + String(format: "%.2f", order![indexPath.row].drink.price) + " x " + String(order![indexPath.row].quantity)
    cell.itemTotal.text = "£" + String(format: "%.2f", Double(order![indexPath.row].quantity) * order![indexPath.row].drink.price)
    return cell
  }
  
  

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
      if (segue.identifier == "qrConfirmToQRScan") {
      let view: QRViewController = segue.destination as! QRViewController;
      view.order = order
      view.subTotal = subTotal
    }
  }
  
  

}
