//
//  HomeViewController.swift
//  DemoProjectTicon
//
//  Created by Md. Mehedi Hasan on 12/6/20.
//  Copyright © 2020 Mehedihasan290. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseFirestore

class HomeViewController: UIViewController {

    //MARK: outlets
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var message: UITextField?
    //======  vars
    var ref: DatabaseReference!
    var db = Firestore.firestore()
    let user = Auth.auth().currentUser
    var name:String = "value not changed"
    var messageList = [Message]()

     
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        getName()
        let seconds = 2.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.loadMessage()
        }
       


    }
    override func viewDidAppear(_ animated: Bool) {
           self.navigationController?.navigationBar.isHidden = true
        self.userEmail.text = Auth.auth().currentUser?.email
       }
    
    
    //MARK: actions
    @IBAction func logoutBtnClicked(_ sender: Any) {
        try! Auth.auth().signOut()
        self.performSegue(withIdentifier: "HomeToLogin", sender: self)
    }
    
    @IBAction func messageSendBtnClicked(_ sender: Any) {
        let message = [ "sender" : self.name , "message" : self.message?.text ?? "" , "email" : Auth.auth().currentUser?.email! ?? "error finding user" , "date" : NSDate().timeIntervalSince1970 ] as [String:Any]
        
        self.ref.child("chat").childByAutoId().setValue(message)
        self.message?.text = ""
        
    }
    
    
    // MARK: Functions
    
    func getName(){
        db.collection("users").whereField("uid", isEqualTo: user!.uid).getDocuments() { (querySnapshot, err) in
                      if let err = err {
                          print("Error getting documents: \(err)")
                      } else {
                          for document in querySnapshot!.documents {
                              
                              //print("\(document.documentID) => \(document.data())")
                              let result = Result {
                              try document.data(as: Message.self)
                  
                              }
                              switch result {
                                 case .success(let msg):
                                     if let msg = msg {
                                        self.name = msg.name ?? "error from 'getname'"
                                      
                                     } else {
                                         print("Document does not exist")
                                     }
                                 case .failure(let error):
                                     print("Error decoding city: \(error)")
                                 }
                          }
                      }
                    }
                }//end of get name
    
    func loadMessage(){
        self.ref.child("chat").queryOrdered(byChild: "date").observe(.value, with:
            {
                (snapshot) in
                //-----
                self.messageList.removeAll()
                if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                   // let chatData : [String:AnyObject]
                    for snap in snapshot {
                        if let messageData = snap.value as? [String:AnyObject]{
                            let name = messageData["sender"] as? String
                            let date = messageData["date"] as? Double
                            let email = messageData["email"] as? String
                            let message = messageData["message"] as? String
                            
                            
                            self.messageList.append(Message(name: name, date: self.getDateFromTimeStamp(timeStamp: date ?? 2121112211) , email: email, message: message))


                        }
                    }
                    self.tableview.reloadData()
                    let indexpath = IndexPath(row: self.messageList.count-1 , section: 0)
                    if self.messageList.count != 0 {
                        self.tableview.scrollToRow(at: indexpath, at: .bottom, animated: true )

                    }
                }
        }
        
        )
         
    }//end of load message
    
    func getDateFromTimeStamp(timeStamp : Double) -> String {

        let date = NSDate(timeIntervalSince1970: timeStamp)

        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "dd MMM YY, hh:mm a"
     // UnComment below to get only time
    //  dayTimePeriodFormatter.dateFormat = "hh:mm a"

        let dateString = dayTimePeriodFormatter.string(from: date as Date)
        return dateString
    }
    
    

}
//MARK: tableview

extension HomeViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(messageList)
       return self.messageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell  {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! chatTableViewCell
        
        cell.date.text =  messageList[indexPath.row].date
        cell.email.text = messageList[indexPath.row].email
        cell.name.text = messageList[indexPath.row].name
        cell.message.text = messageList[indexPath.row].message

        return cell
        
    }
    
    
    
}
