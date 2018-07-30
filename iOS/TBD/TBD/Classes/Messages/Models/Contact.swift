//
//  Contact.swift
//  TBD
//
//  Created by Mihai Betej on 19/07/2018.
//  Copyright © 2018 Shivering Singletons. All rights reserved.
//

import Foundation

struct Contact {
    let fullname: String
    var messages: [Message]?
}

extension Contact {
    init(name: String) {
        fullname = name
    }
}
