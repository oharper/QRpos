//
//  Drinks.swift
//  QRpos
//
//  Created by Owen Harper on 29/10/2017.
//  Copyright © 2017 Owen Harper. All rights reserved.
//

import UIKit

class Drinks {
  
  var current: [Drink]? = [Drink(Name:"SELECT CATEGORY BELOW", Price: 0.0)]
  var beer: [Drink]? = []
  var wine: [Drink]? = []
  var spirits: [Drink]? = []
  var soft: [Drink]? = []
  
  init() {
    
    GetDrinks(Category: "Beer", completionHandler: { response in
      self.beer = response
      self.current = self.beer
    })
    
    GetDrinks(Category: "Wine", completionHandler: { response in
      self.wine = response
    })
    
    GetDrinks(Category: "Spirits", completionHandler: { response in
      self.spirits = response
    })
    
    GetDrinks(Category: "Soft", completionHandler: { response in
      self.soft = response
    })
    
  }
  
}

