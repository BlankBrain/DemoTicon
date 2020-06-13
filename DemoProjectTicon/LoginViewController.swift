//
//  LoginViewController.swift
//  DemoProjectTicon
//
//  Created by Md. Mehedi Hasan on 12/6/20.
//  Copyright © 2020 Mehedihasan290. All rights reserved.
//

import UIKit
import FirebaseAuth 

class LoginViewController: UIViewController {

    //MARK: outlets
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: Check if the user is already signed in
        guard Auth.auth().currentUser != nil else{
            return
        }
        //MARK: segue
        self.performSegue(withIdentifier: "userAlreadySignedIn", sender: self)

    }
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    //MARK: Actions
    @IBAction func loginBtnClicked(_ sender: Any) {
        
        if(Validation.validateEmail(enteredEmail: email.text ?? "" ) == true && Validation.validatePasswordForLogin(password: password.text ?? "" ) == true ){
            
            //MARK: signin code
            
            Auth.auth().signIn(withEmail: email.text! , password: password.text!) { (result, Error) in
                if(Error != nil ){
                    AlartController.showAlart(self, title: "Error", message: Error?.localizedDescription ?? "")
                }else{
            
            //MARK: Check Email Verification , if not verified send email if verified send to homepage
                    
            switch  result?.user.isEmailVerified {
            case true:
                self.performSegue(withIdentifier: "loginToHome", sender: self)
            case false:
                result?.user.sendEmailVerification(completion: { (error) in
                if(error != nil){
                AlartController.showAlart(self, title: "error", message: "unable to send verification email!")
                    }else{
                    return self.performSegue(withIdentifier: "emailSent", sender: self)
                    
                    }
                  AlartController.showAlart(self, title: "error", message: "unable to send verification email!")
                })
            default:
                AlartController.showAlart(self, title: "error!", message: "email varification failed !")
            }//end of email
             

                }//end of sign in
            }
        }else{
            
            AlartController.showAlart(self, title: "opps !", message: "Incorrect data input!")
        }
        
    }
    

}
