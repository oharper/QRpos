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
  var tabExists: Bool? = false
  
  
  //MARK Actions
  @IBAction func closeTabPressed(_ sender: Any) {
  
    //Check to see if text field is blank
    if tabTextField.text == "" {
      
      let alert = UIAlertController(title: "Enter Tab", message: "Please enter a tab to close", preferredStyle: .alert)
      let acceptAction = UIAlertAction(title: "Accept", style: .default) { (alert: UIAlertAction!) -> Void in
        self.tabTextField.becomeFirstResponder()
        return
      }
      alert.addAction(acceptAction)
      present(alert, animated: true, completion:nil)
    }
    
    //Gets the tab to close from text field
    let tabToClose = tabTextField.text
    
    //API check tab exists, return tabExists = true if it does
    let tabExists = true
    
    //Method for if tab exists
    if tabExists {
      
      //Asks user to confirm close
      let alert = UIAlertController(title: "Are you sure?", message: "Are you sure you want to close Tab: " + String(tabToClose!), preferredStyle: .alert)
      let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (alert: UIAlertAction!) -> Void in
      }
      let closeAction = UIAlertAction(title: "Close", style: .destructive) { (alert: UIAlertAction!) -> Void in
        
        //API close tab action here, return closeSuccess = true if successful
        let closeSuccess = true
        
        //Method to notify user close was successful
        if closeSuccess {
          
          let alert = UIAlertController(title: "Tab Closed", message: "Tab: " + String(tabToClose!) + " has been closed", preferredStyle: .alert)
          let acceptAction = UIAlertAction(title: "Accept", style: .default) { (alert: UIAlertAction!) -> Void in
            self.performSegue(withIdentifier: "closeTabToInitial", sender: nil)
          }
          alert.addAction(acceptAction)
          self.present(alert, animated: true, completion:nil)
          
        }
        //Method to notify user of fail
        else {
          
          let alert = UIAlertController(title: "Error", message: "There is an error closing tab: " + String(tabToClose!), preferredStyle: .alert)
          let acceptAction = UIAlertAction(title: "Accept", style: .default) { (alert: UIAlertAction!) -> Void in
            self.tabTextField.becomeFirstResponder()
          }
          alert.addAction(acceptAction)
          self.present(alert, animated: true, completion:nil)
        }
        
      }
      
      alert.addAction(cancelAction)
      alert.addAction(closeAction)
      
      present(alert, animated: true, completion:nil)
      
    }

    //Method if tab doesnt exist
    else if !tabExists {
      
      let alert = UIAlertController(title: "Invalid Tab", message: "The tab you entered does not exist", preferredStyle: .alert)
      let acceptAction = UIAlertAction(title: "Accept", style: .default) { (alert: UIAlertAction!) -> Void in
        self.tabTextField.becomeFirstResponder()
      }
      alert.addAction(acceptAction)
      present(alert, animated: true, completion:nil)
      
    }
    
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
