//
//  FeedItemModel.swift
//  TBD
//
//  Created by Emanuel Jarnea on 19/07/2018.
//  Copyright © 2018 Shivering Singletons. All rights reserved.
//

import UIKit

struct FeedItemModel {
    let username: String
    let avatarImage: UIImage
    let text: String
    let attachment: MediaType?
    let reactions: Int
    let hoursAgo: Int
    
    enum MediaType {
        case image(imageData: UIImage)
        case video(fileName: String, imageData: UIImage)
    }
}
