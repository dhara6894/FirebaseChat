//
//  LoginViewController.swift
//  FirebaseDemo
//
//  Created by dhara.patel on 31/03/17.
//  Copyright © 2017 SA. All rights reserved.
//

import UIKit
import Firebase
class LoginViewController: UIViewController , UITextFieldDelegate{
    var ref: FIRDatabaseReference!
    var userData = String()
    var passData = String()
    @IBOutlet weak var IBtxtPassword: UITextField!
    @IBOutlet weak var IBtxtUserName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        IBtxtUserName.delegate = self
        IBtxtPassword.delegate = self
        ref = FIRDatabase.database().reference()
        //IBtxtUserName.text = "dhara123"
        //IBtxtPassword.text = "123"
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func btnLogin(_ sender: Any) {
        
        if IBtxtUserName.text?.isEmpty == true{
            showAlertDialog(self, message: "please enter username", title: "", clickAction: {})
        }else if IBtxtPassword.text?.isEmpty == true{
            showAlertDialog(self, message: "please enter password", title: "", clickAction: {})
        }else{
            let postsRef = ref.child("Login")
            postsRef.observe(.value, with: { (snapshot) in
                if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                    for snap in snapshot{
                        let value = snap.value as? [String:AnyObject]
                        if self.IBtxtUserName.text == value?["username"] as? String && self.IBtxtPassword.text == value?["password"] as? String{
                            self.userData = self.IBtxtUserName.text!
                            self.passData = self.IBtxtPassword.text!
                        }
                    }
                }
            if !self.userData.isEmpty  && !self.passData.isEmpty{
                   let defaults = UserDefaults.standard
                   defaults.set(self.IBtxtUserName.text, forKey: "UserName")
                   defaults.synchronize()
                   let userVC = UserViewController(nibName: "UserViewController", bundle: nil)
                   self.navigationController?.pushViewController(userVC, animated: true)
            }else{
                   self.showAlertDialog(self, message: "wrong username and password", title: "", clickAction: {})
            }
            })
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    @IBAction func btnSignIn(_ sender: Any) {
        let registerVC = RegisterViewController(nibName: "RegisterViewController", bundle: nil)
        self.present(registerVC, animated: true, completion: nil)
    }
   func showAlertDialog(_ viewController:UIViewController, message:String, title: String, clickAction:@escaping ()->() ) {
    let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alertView.message = message
    alertView.title = title
    alertView.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
        clickAction()
    }))
    viewController.present(alertView, animated: true, completion: nil)
   }
}
