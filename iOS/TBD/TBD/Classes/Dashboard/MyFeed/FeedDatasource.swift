//
//  FeedDatasource.swift
//  TBD
//
//  Created by Emanuel Jarnea on 19/07/2018.
//  Copyright © 2018 Shivering Singletons. All rights reserved.
//

import Foundation

let defaultUsername = "Rafael Smith"

class FeedDatasource {
    private(set) var items: [FeedItemModel] = []
    
    static let instance = FeedDatasource()
    
    private init() {
        let i1 = FeedItemModel(username: "cureleukaemia", avatarImage: #imageLiteral(resourceName: "av_1"), text: "Nurse Sam Set For Half Marathon", attachment: FeedItemModel.MediaType.image(imageData: #imageLiteral(resourceName: "news_1")), reactions: 43, hoursAgo: 2)
        
        let i2 = FeedItemModel(username: "cureleukaemia", avatarImage: #imageLiteral(resourceName: "av_1"), text: "HRH Prince Edward, Earl of Wessex, will visit the Center for Clinical Haematology", attachment: FeedItemModel.MediaType.image(imageData: #imageLiteral(resourceName: "news_2")), reactions: 63, hoursAgo: 2)
        
        let i3 = FeedItemModel(username: "John Stevenson", avatarImage: #imageLiteral(resourceName: "av_2"), text: "The wonderful staff at the Center for Clinical Haematology are taking part in the Brindleyplace Dragonboat Race this year and they need your support to hit their fundraising ...", attachment: nil, reactions: 12, hoursAgo: 4)
        
        let i4 = FeedItemModel(username: "Rafael Smith", avatarImage: #imageLiteral(resourceName: "av_3"), text: "Two great #FundraiseFriday mentions this week! 1) Firstly, a massive well done to 'The Self-raisin Squad' for completing the Tough Mudder on Saturday, raising over £1,490!", attachment: nil, reactions: 0, hoursAgo: 5)
        
        let i5 = FeedItemModel(username: "Elizabeth Gordon", avatarImage: #imageLiteral(resourceName: "av_4"), text: "The wonderful staff at the Center for Clinical Haematology are taking part in the Brindleyplace Dragonboat Race this year and they need your support to hit their fundraising ...", attachment: nil, reactions: 0, hoursAgo: 5)
        
        items = [i1, i2, i3, i4, i5]
    }
    
    func addNew(item: FeedItemModel)  {
        items.insert(item, at: 0)
    }
}
