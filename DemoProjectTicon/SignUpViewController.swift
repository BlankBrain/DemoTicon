//
//  SignUpViewController.swift
//  DemoProjectTicon
//
//  Created by Md. Mehedi Hasan on 13/6/20.
//  Copyright © 2020 Mehedihasan290. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password1: UITextField!
    @IBOutlet weak var password2: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewDidAppear(_ animated: Bool) {
              self.navigationController?.navigationBar.isHidden = false
          }

    @IBAction func sinupBtnClicked(_ sender: Any) {
       signup()
    }
    
     
    func signup(){
        //MARK: validation
                      
        if(  name.text != "" && Validation.validateEmail(enteredEmail: email.text ?? "") == true && Validation.validatePasswordForLogin(password: self.password1.text ?? "") == true && password1.text ?? "" == password2.text){
                          
                          //MARK: Create user
                          Auth.auth().createUser(withEmail: email.text!, password: password1.text!) { (result, Error) in
                              if Error != nil {
                                  AlartController.showAlart(self, title: "error!", message: "Signup Failed !")
                              }else{
                         //MARK: Insert user Data
                                  let db = Firestore.firestore()
                                  db.collection("users").addDocument(data: ["name": self.name.text! ,  "email": self.email.text! ,  "uid": result?.user.uid ?? "" ]) { (Error) in
                                      if Error != nil {
                                                         AlartController.showAlart(self, title: "error!", message: "user data save Failed !")
                                                     }else{
                                          
                                                              Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
                                                              if(error != nil){
                                                              AlartController.showAlart(self, title: "error", message: "unable to send verification email!")
                                                                  }else{
                                                                  self.performSegue(withIdentifier: "signupToEmail", sender: self)
                                                                  }
                                                                AlartController.showAlart(self, title: "error", message: "unable to send verification email!")
                                                              })
                                                          }
                                      
                                  }                }
                          }
                      }else{
                          AlartController.showAlart(self, title: "Error!", message: "Invalid form Input!")
                          password1.text = ""
                          password2.text = ""
                      }
    }
   
}
