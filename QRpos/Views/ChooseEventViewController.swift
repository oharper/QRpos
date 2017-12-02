//
//  ChooseEventViewController.swift
//  QRpos
//
//  Created by Owen Harper on 31/10/2017.
//  Copyright © 2017 Owen Harper. All rights reserved.
//

import UIKit

class ChooseEventViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
  
  //MARK Outlets
  @IBOutlet weak var picker: UIPickerView!
  
  //MARK Variables
  var events: [String]! = []
  
  @IBAction func donePressed(_ sender: Any) {
    
    if !(events?.isEmpty)! {
      
      currentEvent = events![picker.selectedRow(inComponent: 0)]
      self.dismiss(animated: false, completion: nil)
      
    }
  }
  
  @IBAction func backPressed(_ sender: Any) {
    self.dismiss(animated: false, completion: nil)
  }
  
  //MARK ViewDidLoad
  override func viewDidLoad() {
        super.viewDidLoad()
    
    api.getCurrentEvents() { (eventArray, status) -> Void in
      DispatchQueue.main.async(execute: {
        if status == 200 {
          self.events = eventArray
          self.picker.reloadAllComponents()
        } else {
        }
      })
    }
    
    self.picker.delegate = self
    self.picker.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  //MARK Picker Methods
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    
    if events != nil {
    return (events?.count)!
    } else {
      return 0
    }
    
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return events?[row]
  }
  
  
}
