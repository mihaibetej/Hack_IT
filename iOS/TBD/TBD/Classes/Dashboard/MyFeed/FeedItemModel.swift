//
//  FeedItemModel.swift
//  TBD
//
//  Created by Emanuel Jarnea on 19/07/2018.
//  Copyright © 2018 Shivering Singletons. All rights reserved.
//

import Foundation

struct FeedItemModel {
    let text: String
    let attachments: [Media]
    
    struct Media {
        
        enum MType {
            case image
            case video
            case url
        }
        
        let name: String
        let type: MType
    }
}
