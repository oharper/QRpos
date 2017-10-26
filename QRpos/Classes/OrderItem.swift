//
//  OrderItem\.swift
//  QRpos
//
//  Created by Owen Harper on 25/10/2017.
//  Copyright © 2017 Owen Harper. All rights reserved.
//

import UIKit

class OrderItem {
  
  var drink: Drink
  var quantity: Int
  
  init(Drink:Drink, Quantity: Int) {
    
    self.drink = Drink
    self.quantity = Quantity
    
  }
  
  
}
