//
//  Message.swift
//  DemoProjectTicon
//
//  Created by Md. Mehedi Hasan on 13/6/20.
//  Copyright © 2020 Mehedihasan290. All rights reserved.
//

import Foundation
import FirebaseFirestoreSwift
struct Message :Codable {

    var name: String?
    var email: String?
    var date: String?
    var message: String?
   

    init( name: String?,
          date: String?,
          email: String?,
          message: String?
          ){
        self.name = name ?? ""
        self.date = date ?? ""
        self.email = email ?? ""
        self.message = message ?? ""
        
    }

}

