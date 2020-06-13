//
//  ResetPassViewController.swift
//  DemoProjectTicon
//
//  Created by Md. Mehedi Hasan on 13/6/20.
//  Copyright © 2020 Mehedihasan290. All rights reserved.
//

import UIKit
import FirebaseAuth

class ResetPassViewController: UIViewController {
    @IBOutlet weak var email: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewDidAppear(_ animated: Bool) {
           self.navigationController?.navigationBar.isHidden = false
       }
    
    @IBAction func resetBtnClicked(_ sender: Any) {
        
        if(Validation.validateEmail(enteredEmail: email.text ?? "" ) == true){
            Auth.auth().sendPasswordReset(withEmail: email.text!) { (error) in
                      if(error != nil ){
                          AlartController.showAlart(self, title: "error", message: error!.localizedDescription)

                      }else{
                          AlartController.showAlart(self, title: "success!", message: "we sent you an email to reset your password !")
                        self.email.text = ""

                      }
                  }//end of auth
        }else{
            AlartController.showAlart(self, title: "Error!", message: "incorrect email address !")

        }
    }
    
   

}
