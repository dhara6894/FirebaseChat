//
//  ChatViewController.swift
//  FirebaseDemo
//
//  Created by dhara.patel on 30/03/17.
//  Copyright © 2017 SA. All rights reserved.
//

import UIKit
import Firebase
class chatData {
    
}
class ChatViewController: UIViewController{
 
    var ref: FIRDatabaseReference!
    var chat = [ChatDataStore]()
    var user = [UserData]()
    @IBOutlet weak var IBtxtMessage: CustomTextField!
    @IBOutlet weak var IBtblChatView: UITableView!{
        didSet{
            setupTableView()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print(user)
        IBtxtMessage.btnSend.addTarget(self, action: #selector(self.sendBtn(sender:)), for: .touchUpInside)
        IBtxtMessage.delegate = self
        IBtblChatView.delegate = self
        IBtblChatView.dataSource = self
        ref = FIRDatabase.database().reference()
        LoadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //------------------------------------------------------
    // MARK:- user define function
    //--------------------------------------------------------
    func sendBtn(sender: UIButton){
      if IBtxtMessage.text?.isEmpty == true{
          showAlertDialog(self, message: "Please Enter Message", title: "", clickAction:{})
      }else{
            guard let sendText = IBtxtMessage.text , sendText != "" else{
            return
            }
           let defaults = UserDefaults.standard
           let sUserName = defaults.string(forKey: "UserName")
           defaults.synchronize()

            let rid = user.first?.uid
            let uname = "Me"
            let message = sendText
            let date = Date().getDateStringFromDate()
            ref.child("ChatData").childByAutoId().setValue(["rid": rid,"userName": sUserName, "message": message, "date": date])
            let chatData = ChatDataStore(cid: " ",rid: rid,userName: sUserName, message: message, date: date)
            self.chat.append(chatData)
            DispatchQueue.main.async {
                self.IBtblChatView.beginUpdates()
                let newIndex = IndexPath(row: self.chat.count - 1, section: 0)
                self.IBtblChatView.insertRows(at: [newIndex], with: .none)
                self.IBtblChatView.endUpdates()
                if self.chat.count > 0 {
                    let _indexPath = IndexPath(row: self.chat.count - 1, section: 0)
                    self.IBtblChatView.scrollToRow(at: _indexPath, at: .bottom, animated: false)
                }
            }
            IBtxtMessage.text = ""
    }
    }
    private func setupTableView() {
        IBtblChatView.dataSource = self
        IBtblChatView.delegate = self
        IBtblChatView.allowsSelection = true
        IBtblChatView.separatorStyle = .none
        IBtblChatView.showsVerticalScrollIndicator = false
        IBtblChatView.showsHorizontalScrollIndicator = false
        IBtblChatView.keyboardDismissMode = .onDrag
        IBtblChatView.backgroundColor = .clear
        IBtblChatView.layoutMargins = .zero
        IBtblChatView.contentInset = .zero
        IBtblChatView.estimatedRowHeight = 115
        IBtblChatView.rowHeight = UITableViewAutomaticDimension
    }
    func LoadData(){
        let postsRef = self.ref.child("ChatData")
        postsRef.observeSingleEvent(of: .value, with: {(snapshot) in
        if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
            for snap in snapshot{
                    let cKey = snap.key
                    let value = snap.value as? [String:AnyObject]
                    print(value)
                   // let uname = value?["userName"] as! String
                if self.user.first?.uid == value?["rid"] as? String || value?["userName"] as? String == self.user.first?.username{
                        let rid = self.user.first?.uid
                        let uname = value?["userName"] as! String
                        let message = value?["message"] as! String
                        let date = value?["date"] as! String
                        let chatData = ChatDataStore(cid: cKey,rid: rid, userName: uname, message: message, date: date)
                        self.chat.append(chatData)
                        DispatchQueue.main.async {
                            self.IBtblChatView.reloadData()
                        }
                }
            }
        }
        })
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
    //--------------------------------------------------------
    // MARK:- Tableview Delegate & Datasource Method
    //--------------------------------------------------------

extension ChatViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if chat.count > 0{
            return  chat.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chatData = self.chat
//        let defaults = UserDefaults.standard
//        let sUserName = defaults.string(forKey: "UserName")
//        defaults.synchronize()

        if user.first?.username == chatData[indexPath.row].userName{
            var cell = tableView.dequeueReusableCell(withIdentifier: "LeftCell") as? LeftChatCell
            if cell == nil{
                cell = loadNibWithName(nibName: "ChatViewCell", index: 0) as? LeftChatCell
            }
            if chatData.count > 0{
                cell?.IBlblName.text = chatData[indexPath.row].userName
                cell?.IBlblMessage.text = chatData[indexPath.row].message
                cell?.IBlblDate.text = chatData[indexPath.row].date
            }
            return cell!
        }else{
            var cell = tableView.dequeueReusableCell(withIdentifier: "RightCell") as? RightChatCell
            if cell == nil{
                cell = loadNibWithName(nibName: "ChatViewCell", index: 1) as? RightChatCell
            }
            if chatData.count > 0{
                cell?.IBlblName.text = chatData[indexPath.row].userName
                cell?.IBlblMessage.text = chatData[indexPath.row].message
                cell?.IBlblDate.text = chatData[indexPath.row].date
            }
            return cell!
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
}
   //--------------------------------------------------------
   // MARK:- TextField Delegate Method
   //--------------------------------------------------------

extension ChatViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
extension UIViewController {
    func loadNibWithName(nibName:String, index:Int) -> Any {
        return Bundle.main.loadNibNamed(nibName, owner: self, options: nil)![index]
    }
}
extension Date{
    func getDateStringFromDate() -> String    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let dateString = dateFormatter.string(from: self)
        return dateString as String
    }
}
