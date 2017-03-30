//
//  ViewController.swift
//  FirebaseDemo
//
//  Created by dhara.patel on 28/03/17.
//  Copyright © 2017 SA. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    var isLogin:Bool = true
    var status:Int?
    var ref: FIRDatabaseReference!
    @IBOutlet weak var IBlblUname: UILabel!
    @IBOutlet weak var IBtxtUname: UITextField!
    @IBOutlet weak var IBtxtPass: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
//        if isLogin{
//            status = 0
//        }else{
//            status = 1
//        }
//        isLogin = false
        ref = FIRDatabase.database().reference()
        ref.child("UserLogin").child("username")
        ref.child("UserLogin").child("password")
        ref.child("UserLogin").child("status")
       
        ref.observe(FIRDataEventType.value, with: {(snapshot) in
            let data = snapshot.value as? [String:AnyObject] ?? [:]
            print(data)
            self.IBlblUname.text = data["username"] as! String?
            if self.IBlblUname.text == "dhara"{
               self.IBlblUname.backgroundColor = UIColor.red
            }else{
                self.IBlblUname.backgroundColor = UIColor.gray
            }
        })
       // self.ref.child("users").child(user.uid).setValue(["username": username])
        print(ref.key)
       
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func btnLogin(_ sender: Any) {
        let uname = IBtxtUname.text
        let pass = IBtxtPass.text
        ref.setValue(["username": uname as Any,"password": pass as Any, "status": 0])
        ref.observe(FIRDataEventType.value, with: {(snapshot) in
            let data = snapshot.value as? [String:AnyObject] ?? [:]
            print(data)
        })
        IBtxtUname.text = ""
        IBtxtPass.text = ""
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
}

