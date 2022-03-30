//
//  ViewController.swift
//  FoursquareClone
//
//  Created by Birkan Pusa on 6.01.2022.
//

import UIKit
import Parse


class SignUpVC: UIViewController {
    
    
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        /*
        let parseObject = PFObject(className: "Fruits")
        parseObject["name"] = "Banane"
        parseObject["calories"] = 150
        parseObject.saveInBackground { success, error in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                print("ok")
            }
        }
         
        
        let query = PFQuery(className: "Fruits")
        query.whereKey("calories", greaterThan: 140)
        query.findObjectsInBackground { objects, error in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                print(objects)
            }
        }*/
        
        
    }
    
    @IBAction func signInClicked(_ sender: Any) {
        
        if usernameText.text != "" && passwordText.text != "" {
            
            PFUser.logInWithUsername(inBackground: usernameText.text!, password: passwordText.text!) { user, error in
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                } else {
                    self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
                }
            }
            
        } else {
            self.makeAlert(titleInput: "Error", messageInput: "Enter username and password")
        }
        
    }
    
    //üyelik fonksiyonu
    @IBAction func signUpClicked(_ sender: Any) {
        
        //username ve şifre boş değilse
        if usernameText.text != "" && passwordText.text != "" {
            
            let user = PFUser()
            user.username = usernameText.text!
            user.password = passwordText.text!
            
            user.signUpInBackground { success, error in
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error!")
                } else {
                    self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
                }
            }
            
        } else {
            makeAlert(titleInput: "Error", messageInput: "Enter username and password")
        }
        
    }
    
    func makeAlert(titleInput: String, messageInput: String) {
        
    let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
    let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
    alert.addAction(okButton)
    self.present(alert, animated: true, completion: nil)
        
    }

}

