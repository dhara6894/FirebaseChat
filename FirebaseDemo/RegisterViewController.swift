//
//  LoginViewController.swift
//  FirebaseDemo
//
//  Created by dhara.patel on 31/03/17.
//  Copyright © 2017 SA. All rights reserved.
//

import UIKit
import Firebase
class RegisterViewController: UIViewController , UITextFieldDelegate{

    var ref: FIRDatabaseReference!
    @IBOutlet weak var IbtxtFname: UITextField!
    @IBOutlet weak var IBtxtLname: UITextField!
    @IBOutlet weak var IBtxtPassword: UITextField!
    @IBOutlet weak var IBtxtUserName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        IbtxtFname.delegate = self
        IBtxtLname.delegate = self
        IBtxtUserName.delegate = self
        IBtxtPassword.delegate = self
        ref = FIRDatabase.database().reference()
        ref.child("Login")
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func btnRegister(_ sender: Any) {
        let fname = IbtxtFname.text
        let lname = IBtxtLname.text
        let uname = IBtxtUserName.text
        let pass = IBtxtPassword.text
        ref.child("Login").childByAutoId().setValue(["fname": fname as Any,"lname": lname as Any ,"username": uname as Any,"password": pass as Any])
       //ref.childByAutoId().setValue(["username": uname as Any,"password": pass as Any])
//        ref.observe(FIRDataEventType.value, with: {(snapshot) in
//            let data = snapshot.value as? [String:AnyObject] ?? [:]
//            print(data)
//        })
        IbtxtFname.text = ""
        IBtxtLname.text = ""
        IBtxtUserName.text = ""
        IBtxtPassword.text = ""
        self.dismiss(animated: true, completion: nil)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
