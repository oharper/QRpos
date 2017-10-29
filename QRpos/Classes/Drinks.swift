//
//  Drinks.swift
//  QRpos
//
//  Created by Owen Harper on 29/10/2017.
//  Copyright © 2017 Owen Harper. All rights reserved.
//

import UIKit

class Drinks {
  
  var current: [Drink]?
  var beer: [Drink]?
  var wine: [Drink]?
  var spirits: [Drink]?
  var soft: [Drink]?
  
  init() {
    
    //API call to populate categories
    //TEST DATA
    self.beer = [Drink(Name: "Carling", Price: 3.80), Drink(Name: "Fosters", Price: 4.00)]
    self.wine = []
    self.spirits = []
    self.soft = [Drink(Name: "Coke", Price: 2.00),Drink(Name: "Fanta", Price: 1.80)]
    
    self.current = self.beer
  }
  
}

