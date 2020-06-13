//
//  HomeViewController.swift
//  DemoProjectTicon
//
//  Created by Md. Mehedi Hasan on 12/6/20.
//  Copyright © 2020 Mehedihasan290. All rights reserved.
//

import UIKit
import FirebaseAuth 

class HomeViewController: UIViewController {

    @IBOutlet weak var userEmail: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewDidAppear(_ animated: Bool) {
           self.navigationController?.navigationBar.isHidden = true
        self.userEmail.text = Auth.auth().currentUser?.email
       }
    
    @IBAction func logoutBtnClicked(_ sender: Any) {
        
        try! Auth.auth().signOut()
        self.performSegue(withIdentifier: "HomeToLogin", sender: self)

    }
    

}
