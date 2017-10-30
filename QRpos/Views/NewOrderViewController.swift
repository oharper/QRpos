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
  var currentOrder = Order()
  var currentDrinks = Drinks()
  
  //MARK Actions
  @IBAction func voidPressed(_ sender: Any) {
    performSegue(withIdentifier: "newOrderToInitial", sender: nil)
  }
  
  @IBAction func donePressed(_ sender: Any) {
    if !(currentOrder.drinks?.isEmpty)! {
    performSegue(withIdentifier: "newOrderToPayment", sender: nil)
    }
  }
  
  //MARK ViewDidLoad
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.drinkSelectTable.dataSource = self
    self.drinkSelectTable.delegate = self
    self.orderTable.dataSource = self
    self.orderTable.delegate = self
    self.tabBar.delegate = self
    
    //***FIX find method to tap on beer tab rather than just show as selected (to change the current category to beer)
    //Selects first item in tab bar
    tabBar.selectedItem = (tabBar.items?[0])! as UITabBarItem;
    
    //Sets the initial text of total label
    totalLabel.text = "Total: £" + String(format: "%.2f", currentOrder.total)
    
    
    GetDrinks(Category: "Wine", completionHandler: { response in
      self.currentDrinks.wine = response
    })
    
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
      return currentDrinks.current!.count
    } else {
      return currentOrder.drinks!.count
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if tableView.tag == 1 {
      let cell = tableView.dequeueReusableCell(withIdentifier: "DrinkSelectionCell", for: indexPath) as! DrinkSelectionCell
      cell.name.text = currentDrinks.current![indexPath.row].name
      cell.price.text = "£" + String(format: "%.2f", currentDrinks.current![indexPath.row].price)
      return cell
    } else {
      let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath) as! OrderCell
      cell.name.text = currentOrder.drinks![indexPath.row].drink.name
      cell.itemPrice.text = "£" + String(format: "%.2f", currentOrder.drinks![indexPath.row].drink.price) + " x " + String(currentOrder.drinks![indexPath.row].quantity)
      cell.itemTotal.text = "£" + String(format: "%.2f", Double(currentOrder.drinks![indexPath.row].quantity) * currentOrder.drinks![indexPath.row].drink.price)
      return cell
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    if tableView.tag == 1 {
      addToOrder(Drink: currentDrinks.current![indexPath.row])
    } else {
      removeFromOrder(Drink: currentOrder.drinks![indexPath.row].drink)
    }
  }
  
  //Function to switch the category shown using tab bar
  func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
    switch item.tag  {
    case 0:
      currentDrinks.current = currentDrinks.beer
      break
    case 1:
      currentDrinks.current = currentDrinks.wine
      break
    case 2:
      currentDrinks.current = currentDrinks.spirits
      break
    case 3:
      currentDrinks.current = currentDrinks.soft
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
    currentOrder.total = currentOrder.total + Drink.price
    totalLabel.text = "Total: £" + String(format: "%.2f", currentOrder.total)
    var drinkExists = false
    for item in currentOrder.drinks! {
      if item.drink.name == Drink.name {
        drinkExists = true
        item.quantity += 1
        break
      }
    }
    if !drinkExists {
      currentOrder.drinks?.append(OrderItem(Drink: Drink, Quantity: 1))
    }
    self.orderTable.reloadData()
  }
  
  //Function that removes a given drink from the order or decrements the quantity
  func removeFromOrder(Drink: Drink) {
    currentOrder.total = currentOrder.total - Drink.price
    totalLabel.text = "Total: £" + String(format: "%.2f", currentOrder.total)
    for (index, element) in (currentOrder.drinks?.enumerated())! {
      if element.drink.name == Drink.name {
        if element.quantity == 1 {
          currentOrder.drinks?.remove(at: index)
        } else {
          element.quantity -= 1
        }
      }
    }
    self.orderTable.reloadData()
  }
  
  //MARK Segues
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if (segue.identifier == "newOrderToPayment") {
      let view : PaymentViewController = segue.destination as! PaymentViewController;
      view.currentOrder = currentOrder
    }
  }
  

}
