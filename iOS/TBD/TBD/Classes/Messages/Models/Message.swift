//
//  Message.swift
//  TBD
//
//  Created by Mihai Betej on 19/07/2018.
//  Copyright © 2018 Shivering Singletons. All rights reserved.
//

import Foundation

enum MessageType {
    case incoming
    case outgoing
}

struct Message {
    let content: String
    let type: MessageType
    let sender: String
}
