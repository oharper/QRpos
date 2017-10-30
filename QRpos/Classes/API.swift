//
//  API.swift
//  QRpos
//
//  Created by Owen Harper on 30/10/2017.
//  Copyright © 2017 Owen Harper. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


func GetDrinks(Category: String, completionHandler: @escaping (_ drinkArray: [Drink]) -> Void) {
  var drinksArray: [Drink] = []
  
  let url = "http://172.16.121.178:51692/api/drinks"
  let params = ["Category": Category,
                "eventName": currentEvent]
  
  Alamofire.request(url, method: .get, parameters: params).responseJSON { (responseData) -> Void in
    if((responseData.result.value) != nil) {
      let jsonResult = JSON(responseData.result.value!)
      var jsonArray = jsonResult["value"].array
      
      for drink in jsonArray! {
        var currentDrink = Drink(Name: drink["Name"].string!, Price: drink["Price"].double!)
        drinksArray.append(currentDrink)
      }
      completionHandler(drinksArray as! [Drink])
    }
  }
}
