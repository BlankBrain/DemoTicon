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

    }
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    //MARK: Actions
    @IBAction func loginBtnClicked(_ sender: Any) {
    }
    

}
