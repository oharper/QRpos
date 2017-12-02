//
//  CloseTabViewController.swift
//  QRpos
//
//  Created by Owen Harper on 25/10/2017.
//  Copyright © 2017 Owen Harper. All rights reserved.
//

import UIKit

class CloseTabViewController: UIViewController {

  //MARK Outlets
  @IBOutlet weak var tabTextField: UITextField!
  @IBOutlet weak var closeButton: UIButton!
  
  //MARK Variables
  var tabToClose: String?
  
  //MARK Actions
  @IBAction func backPressed(_ sender: Any) {  
    self.dismiss(animated: false, completion: nil)
  }
  
  @IBAction func closeTabPressed(_ sender: Any) {
    
    if checkTextField() {
    
    //API Call to check tab exists
    api.checkTabStatus(tabToClose!) { (tabStatus, status) -> Void in
      DispatchQueue.main.async(execute: {
        
        if status == 200 {
          self.confirmClose()
        } else {
          self.tabDoesntExist()
        }
      })
    }
    }
  }
  
  
  func checkTextField() -> Bool{
  //Check to see if text field is blank
  if tabTextField.text == "" {
    emptyTextAlert()
    return false
  } else {
    //Gets the tab to close from text field
    self.tabToClose = tabTextField.text
    return true
    }
  }
  
  func emptyTextAlert() {
    let alert = UIAlertController(title: "Enter Tab", message: "Please enter a tab to close", preferredStyle: .alert)
    let acceptAction = UIAlertAction(title: "Accept", style: .default) { (alert: UIAlertAction!) -> Void in
      self.tabTextField.becomeFirstResponder()
      return
    }
    alert.addAction(acceptAction)
    present(alert, animated: true, completion:nil)
  }
  
  
  func tabDoesntExist() {
    let alert = UIAlertController(title: "Invalid Tab", message: "The tab you entered does not exist for the current event.", preferredStyle: .alert)
    let acceptAction = UIAlertAction(title: "Accept", style: .default) { (alert: UIAlertAction!) -> Void in
      self.tabTextField.becomeFirstResponder()
      self.tabTextField.text = ""
    }
    alert.addAction(acceptAction)
    present(alert, animated: true, completion:nil)
  }
  
  
  
  func confirmClose() {
      //Asks user to confirm close
      let alert = UIAlertController(title: "Are you sure?", message: "Are you sure you want to close Tab: " + String(tabToClose!), preferredStyle: .alert)
      let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (alert: UIAlertAction!) -> Void in
      }
      let closeAction = UIAlertAction(title: "Close", style: .destructive) { (alert: UIAlertAction!) -> Void in
        
        self.apiCloseTab()
        
      }
      alert.addAction(cancelAction)
      alert.addAction(closeAction)
      
      present(alert, animated: true, completion:nil)
  }
  
  
  func apiCloseTab(){
    //API CALL TO CLOSE TAB
    let closeSuccess = true
    
    //Method to notify user close was successful
    if closeSuccess {
      closeSuccessAlert()
    }
    else {
      closeFailAlert()
    }
  }
  
  
  func closeSuccessAlert() {
    let alert = UIAlertController(title: "Tab Closed", message: "Tab: " + String(self.tabToClose!) + " has been closed", preferredStyle: .alert)
    let acceptAction = UIAlertAction(title: "Accept", style: .default) { (alert: UIAlertAction!) -> Void in
      self.dismiss(animated: false, completion: nil)
    }
    alert.addAction(acceptAction)
    self.present(alert, animated: true, completion:nil)
  }
  
  
  func closeFailAlert() {
    let alert = UIAlertController(title: "Error", message: "There is an error closing tab: " + String(self.tabToClose!), preferredStyle: .alert)
    let acceptAction = UIAlertAction(title: "Accept", style: .default) { (alert: UIAlertAction!) -> Void in
      self.tabTextField.becomeFirstResponder()
    }
    alert.addAction(acceptAction)
    self.present(alert, animated: true, completion:nil)
  }

  
  
  
  
  //MARK ViewDidLoad
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //Rounds the corners of items
    closeButton.layer.cornerRadius = 6
    closeButton.clipsToBounds = true
    tabTextField.layer.cornerRadius = 6
    tabTextField.clipsToBounds = true
    
    tabTextField.becomeFirstResponder()

  }
  

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
