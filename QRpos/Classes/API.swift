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

//var ip = "172.16.121.178/harpersPOS"
//var ip = "192.168.1.131"
var ip = "172.16.121.178:51695"

class api {

  //GET Current Events
  static func getCurrentEvents(callback: @escaping ([String]?, Int?) -> Void) {
    
    var eventArray: [String] = []
    let url = "http://" + ip + "/api/events"
    let urlEncoded = url.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)

    let request = URLRequest(url: URL(string: urlEncoded)!)
    let session = URLSession.shared
    let task = session.dataTask(with: request as URLRequest, completionHandler: {
      (data, response, error) -> Void in
      
      let status = (response as! HTTPURLResponse).statusCode
      
      if status != 200 {
        
        callback(nil, status)
        
      } else {
        var jsonArray = JSON(data: data!)["Value"].array
        
        for item in jsonArray! {
          eventArray.append(String(describing: item))
        }
        callback(eventArray , status)
      }
      
    })
    
    task.resume()
  }
  
//GET Tab Status
static func checkTabStatus(_ tab : String, callback: @escaping (String?, Int?) -> Void) {
  
  var tabStatus: String?
  let params = "?currentEvent=\(currentEvent)&table=\(tab)";
  let url = "http://" + ip + "/api/tabs/exists" + params
  let urlEncoded = url.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
  
  
  let request = URLRequest(url: URL(string: urlEncoded)!)
  let session = URLSession.shared
  let task = session.dataTask(with: request as URLRequest, completionHandler: {
    (data, response, error) -> Void in
    
    let status = (response as! HTTPURLResponse).statusCode
    
    if status != 200 {
      
      callback(nil, status)
      
    } else {
      
      tabStatus = JSON(data: data!)["Value"].string
      callback(tabStatus , status)
    }
    
  })
  
  task.resume()
}


//GET All drinks
static func getDrinks(callback: @escaping (Drinks?, Int?) -> Void) {

  var drinks: Drinks = Drinks()
  let params = "?eventName=\(currentEvent)"
  let url = "http://" + ip + "/api/drinks" + params
  let urlEncoded = url.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
  
  let request = URLRequest(url: URL(string: urlEncoded)!)
  let session = URLSession.shared
  let task = session.dataTask(with: request as URLRequest, completionHandler: {
    (data, response, error) -> Void in

    let status = (response as! HTTPURLResponse).statusCode

    if status != 200 {

      callback(nil, status)

    } else {
      
      let beerJSONArray = JSON(data: data!)["Beer"].array
      let wineJSONArray = JSON(data: data!)["Wine"].array
      let spiritsJSONArray = JSON(data: data!)["Spirits"].array
      let softJSONArray = JSON(data: data!)["Soft"].array
      
      
      for item in beerJSONArray! {
        let drink = Drink(Name: item["Name"].string!, Price: item["Price"].double!)
        drinks.beer.append(drink)
        drinks.current.append(drink)
      }
      for item in wineJSONArray! {
        let drink = Drink(Name: item["Name"].string!, Price: item["Price"].double!)
        drinks.wine.append(drink)
      }
      for item in spiritsJSONArray! {
        let drink = Drink(Name: item["Name"].string!, Price: item["Price"].double!)
        drinks.spirits.append(drink)
      }
      for item in softJSONArray! {
        let drink = Drink(Name: item["Name"].string!, Price: item["Price"].double!)
        drinks.soft.append(drink)
      }
        
      callback(drinks, status)
    }
  })

  task.resume()
  }





static func createOrder(_ order : Order, callback: @escaping ( Int?, Int?) -> Void) {
  
var params = "?eventName=\(order.event)&paymentMethod=\(order.paymentMethod)&orderTotal=\(order.total)&status=\(order.orderStatus)&preOrder=\(order.preOrder)"
  
  if order.deliveryTable != "" {
    params.append("&deliveryTable=\(order.deliveryTable)")
  }
  if order.tabNumber != "" {
    params.append("&table=\(order.tabNumber)")
  }
  
let url = "http://" + ip + "/api/orders/create" + params
let urlEncoded = url.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
  
  var request = URLRequest(url: URL(string: urlEncoded)!)
//request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
request.httpMethod = "POST"
  let session = URLSession.shared
  let task = session.dataTask(with: request as URLRequest, completionHandler: {
    (data, response, error) -> Void in
    
    let status = (response as! HTTPURLResponse).statusCode
    let data = JSON(data: data!)["OrderID"].int
    
    callback(data, status)
    
  })
  
  task.resume()
  }
  
  

  static func addDrinks(order : Order, orderID : Int, callback: @escaping ( Int?) -> Void) {

    let params = "?orderID=\(orderID)"

    let url = "http://" + ip + "/api/orders/add" + params
    let urlEncoded = url.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)

    var request = URLRequest(url: URL(string: urlEncoded)!)
    request.httpMethod = "POST"
    
    
    
    
    
    var jsonArray: [JSON] = []
    
    for item in order.drinks! {
      var jsonItem = JSON("{DrinkID : " + item.drink.name + ", Quantity: " + String(describing: item.quantity) + "}")
      jsonArray.append(jsonItem)
      
    }

    //Convert jsonArray to Data and serialise? to pass to http body
    var jsonData = jsonArray.data(using: .utf8, allowLossyConversion: false)!
    request.httpBody = jsonArray
    
    
    let session = URLSession.shared
    let task = session.dataTask(with: request as URLRequest, completionHandler: {
      (data, response, error) -> Void in

      let status = (response as! HTTPURLResponse).statusCode

      callback(status)

    })

    task.resume()
  }
  
  


}
