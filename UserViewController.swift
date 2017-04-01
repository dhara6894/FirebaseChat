//
//  UserViewController.swift
//  FirebaseDemo
//
//  Created by dhara.patel on 31/03/17.
//  Copyright © 2017 SA. All rights reserved.
//

import UIKit
import Firebase
class UserViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
 
    var isMine: Bool = false
    var arrUserData = [UserData]()
    var ref: FIRDatabaseReference!
    @IBOutlet weak var IBtvUserView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
          ref = FIRDatabase.database().reference()
        
          IBtvUserView.delegate = self
          IBtvUserView.dataSource = self
          IBtvUserView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "userCell")
        let postsRef = ref.child("Login")
        postsRef.observe(.value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshot{
                    let uKey = snap.key
                    let value = snap.value as? [String:AnyObject]
                    print(value)
                    let fnameData = value?["fname"] as? String
                    let lnameData = value?["lname"] as? String
                    let userData = value?["username"] as? String
                    let passData = value?["password"] as? String
                    let defaults = UserDefaults.standard
                    let sUserName = defaults.string(forKey: "UserName")
                    defaults.synchronize()
                    if sUserName !=  value?["username"] as? String{  //login user not included
                        let uData = UserData(uid: uKey,firstname: fnameData,lastname: lnameData, username: userData, password: passData, isMine: self.isMine)
                        self.arrUserData.append(uData)
                    }
                }
                DispatchQueue.main.async {
                    self.IBtvUserView.reloadData()
                }
            }
            
        })

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if arrUserData.count > 0{
           return arrUserData.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as! UserTableViewCell
        if arrUserData.count > 0{
          let fname = arrUserData[indexPath.row].firstname
          let lname = arrUserData[indexPath.row].lastname
          cell.IBlblUserName.text = fname! + " " + lname!
        }
         return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      //  let cell = tableView.cellForRow(at: indexPath) as! UserTableViewCell
        let chatCell = ChatViewController(nibName: "ChatViewController", bundle: nil)
        chatCell.user = [arrUserData[indexPath.row]]
        self.navigationController?.pushViewController(chatCell, animated: true)
    }
}
