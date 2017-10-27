//
//  newOrderViewController.swift
//  QRpos
//
//  Created by Owen Harper on 24/10/2017.
//  Copyright © 2017 Owen Harper. All rights reserved.
//

import UIKit

class NewOrderViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITabBarDelegate {
  
  //MARK Outlets
  @IBOutlet weak var orderTable: UITableView!
  @IBOutlet weak var drinkSelectTable: UITableView!
  @IBOutlet weak var tabBar: UITabBar!
  @IBOutlet weak var totalLabel: UILabel!
  
  //MARK Variables
  var current: [Drink]? = []
  var order: [OrderItem]? = []
  var subTotal: Double = 0
  
  var beer: [Drink]? = []
  var wine: [Drink]? = []
  var spirits: [Drink]? = []
  var soft: [Drink]? = []
  
  //MARK Actions
  @IBAction func voidPressed(_ sender: Any) {
    performSegue(withIdentifier: "newOrderToInitial", sender: nil)
  }
  
  @IBAction func donePressed(_ sender: Any) {
    if !(order?.isEmpty)! {
    performSegue(withIdentifier: "newOrderToPayment", sender: nil)
    }
  }
  
  
  
  //MARK ViewDidLoad
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //API call to populate each categories drink array
    //TEST DATA:
    soft?.append(Drink(Name: "Coke", Price: 2.00))
    soft?.append(Drink(Name: "Fanta", Price: 1.80))
    beer?.append(Drink(Name: "Carling", Price: 3.80))
    beer?.append(Drink(Name: "Fosters", Price: 4.00))
    
    //Selects first item in tab bar
    tabBar.selectedItem = (tabBar.items?[0])! as UITabBarItem;
    current = beer
    self.drinkSelectTable.reloadData()
    
    self.drinkSelectTable.dataSource = self
    self.drinkSelectTable.delegate = self
    self.orderTable.dataSource = self
    self.orderTable.delegate = self
    self.tabBar.delegate = self
    
    totalLabel.text = "Total: £" + String(format: "%.2f", subTotal)
    
  }
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  //MARK Table View Methods
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    if tableView.tag == 1 {
      return current!.count
      
    } else {
      return order!.count
    }
    
  }
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    if tableView.tag == 1 {
      
      let cell = tableView.dequeueReusableCell(withIdentifier: "DrinkSelectionCell", for: indexPath) as! DrinkSelectionCell
      cell.name.text = current![indexPath.row].name
      cell.price.text = "£" + String(format: "%.2f", current![indexPath.row].price)
      return cell
      
    } else {
      
      let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath) as! OrderCell
      cell.name.text = order![indexPath.row].drink.name
      cell.itemPrice.text = "£" + String(format: "%.2f", order![indexPath.row].drink.price) + " x " + String(order![indexPath.row].quantity)
      cell.itemTotal.text = "£" + String(format: "%.2f", Double(order![indexPath.row].quantity) * order![indexPath.row].drink.price)
      return cell
    }
    
  }
  
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
    if tableView.tag == 1 {
      
      addToOrder(Drink: current![indexPath.row])
      
    } else {
      
      removeFromOrder(Drink: order![indexPath.row].drink)
    }
    
  }
  
  
  //Function to switch the category shown using tab bar
  func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
    
    switch item.tag  {
      
    case 0:
      current = beer
      break
    case 1:
      current = wine
      break
    case 2:
      current = spirits
      break
    case 3:
      current = soft
    case 4:
      //      addOther()
      tabBar.selectedItem = (tabBar.items?[0])! as UITabBarItem;
    default:
      break
    }
    self.drinkSelectTable.reloadData()
    
  }
  
  //MARK Functions
  
  
  
  //Function that adds a given drink to the order or increments the quantity
  func addToOrder(Drink:Drink) {
    
    subTotal = subTotal + Drink.price
    totalLabel.text = "Total: £" + String(format: "%.2f", subTotal)
    
    var drinkExists = false
    
    for item in order! {
      if item.drink.name == Drink.name {
        
        drinkExists = true
        item.quantity += 1
        break
      }
    }
    if !drinkExists {
      order?.append(OrderItem(Drink: Drink, Quantity: 1))
    }
    
    self.orderTable.reloadData()
    
  }
  
  
  //Function that removes a given drink from the order or decrements the quantity
  func removeFromOrder(Drink: Drink) {
    
    subTotal = subTotal - Drink.price
    totalLabel.text = "Total: £" + String(format: "%.2f", subTotal)
    
    for (index, element) in (order?.enumerated())! {
      if element.drink.name == Drink.name {
        
        if element.quantity == 1 {
          
          order?.remove(at: index)
          
        } else {
          
          element.quantity -= 1
        }
      }
    }
    self.orderTable.reloadData()
    
  }
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if (segue.identifier == "newOrderToPayment") {
      let view : PaymentViewController = segue.destination as! PaymentViewController;
      view.order = order
      view.subTotal = subTotal
    }
  }
  
  
  
}
