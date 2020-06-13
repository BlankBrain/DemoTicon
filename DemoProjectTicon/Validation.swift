//
//  Validation.swift
//  DemoProjectTicon
//
//  Created by Md. Mehedi Hasan on 13/6/20.
//  Copyright © 2020 Mehedihasan290. All rights reserved.
//

import Foundation
class Validation{
    
    static var error:String = ""
    static func validateEmail(enteredEmail:String) -> Bool {

        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)

    }
    
    static func validatPassword(p1:String , p2:String ) -> Bool {
        if (p1 == p2 && p1 != "" && validatePasswordForLogin(password: p1)) == true {
            return true
        }
        else{
            return false
        }
    }
    
    static func validatePasswordForLogin(password:String?) -> Bool {
        guard password != nil else { return false }
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    static func validate(text:String ) -> Bool {
        if text != "" {
            return true
        }
        else{
            return false
        }
    }
}

