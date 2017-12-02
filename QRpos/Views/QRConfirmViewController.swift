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
  var currentOrder = Order()
  
  //MARK Actions
  @IBAction func backPressed(_ sender: Any) {
    performSegue(withIdentifier: "qrConfirmToQRScan", sender: nil)
  }
  
  @IBAction func donePressed(_ sender: Any) {
    
    currentOrder.paymentMethod = "Tab"
    
    if tableService {
      currentOrder.deliveryTable = currentOrder.tabNumber
      currentOrder.orderStatus = "Awaiting Delivery"
      
      api.createOrder(currentOrder) { (data, status) -> Void in
        DispatchQueue.main.async(execute: {
          if status == 200 {
            print(data)
          } else {
            print("ERROR:"  + String(describing: status))
          }
        })
      }
      
      
      self.performSegue(withIdentifier: "qrConfirmToInitial", sender: nil)
    } else {
    
    currentOrder.orderStatus = "Awaiting Delivery"
    
    api.createOrder(currentOrder) { (data, status) -> Void in
      DispatchQueue.main.async(execute: {
        if status == 200 {
          print(data)
        } else {
          print("ERROR:"  + String(describing: status))
        }
      })
    }
    
    self.performSegue(withIdentifier: "qrConfirmToInitial", sender: nil)
    }
  }
  
    //MARK ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
      
      self.orderTable.delegate = self
      self.orderTable.dataSource = self
      
      totalLabel.text = "Total: £" + String(format: "%.2f", currentOrder.total)
    }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  //MARK Table Methods
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return (currentOrder.drinks?.count)!
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath) as! OrderCell
    cell.name.text = currentOrder.drinks![indexPath.row].drink.name
    cell.itemPrice.text = "£" + String(format: "%.2f", currentOrder.drinks![indexPath.row].drink.price) + " x " + String(currentOrder.drinks![indexPath.row].quantity)
    cell.itemTotal.text = "£" + String(format: "%.2f", Double(currentOrder.drinks![indexPath.row].quantity) * currentOrder.drinks![indexPath.row].drink.price)
    return cell
  }
  
  //MARK Segues
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if (segue.identifier == "qrConfirmToQRScan") {
      let view: QRViewController = segue.destination as! QRViewController;
      view.currentOrder = currentOrder
    }
  }
  

}
