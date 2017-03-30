//
//  SecondViewController.swift
//  FirebaseDemo
//
//  Created by dhara.patel on 29/03/17.
//  Copyright © 2017 SA. All rights reserved.
//

import UIKit
import  Firebase
class SecondViewController: UIViewController {

    var ref: FIRDatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
 
        ref = FIRDatabase.database().reference()
        ref.observe(FIRDataEventType.value, with: {(snapshot) in
            let data = snapshot.value as? [String:AnyObject] ?? [:]
            print(data)
            if data["status"] as? Int == 1{
                self.navigationController?.popViewController(animated: true)
            }
        })

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
