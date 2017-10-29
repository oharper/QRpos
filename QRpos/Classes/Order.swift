//
//  Order.swift
//  QRpos
//
//  Created by Owen Harper on 28/10/2017.
//  Copyright © 2017 Owen Harper. All rights reserved.
//

import Foundation

class Order {

  var currentEvent: String
  var drinks: [OrderItem]?
  var total: Double
  var orderStatus: String
  var deliveryTable: String
  var paymentMethod: String
  var tabNumber: String

  init(drinks:[OrderItem]? = [], orderStatus: String = "", deliveryTable: String = "", paymentMethod: String = "", currentEvent: String = "", total: Double = 0, tabNumber: String = "") {

    self.currentEvent = currentEvent
    self.drinks = drinks
    self.orderStatus = orderStatus
    self.deliveryTable = deliveryTable
    self.paymentMethod = paymentMethod
    self.total =  total
    self.tabNumber = tabNumber

  }
  
}
