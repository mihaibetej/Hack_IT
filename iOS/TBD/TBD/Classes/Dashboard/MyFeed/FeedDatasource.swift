//
//  FeedDatasource.swift
//  TBD
//
//  Created by Emanuel Jarnea on 19/07/2018.
//  Copyright © 2018 Shivering Singletons. All rights reserved.
//

import Foundation

let defaultUsername = "Simona Halep"

class FeedDatasource {
    private(set) var items: [FeedItemModel] = []
    
    init() {
        let i1 = FeedItemModel(username: defaultUsername, text: "Some text 1", attachments: [
            ])
        
        let i2 = FeedItemModel(username: defaultUsername, text: "This constraint ties an element at zero points from the bottom layout guide: http://www.cureleukaemia.co.uk", attachments: [
            ])
        
        let i3 = FeedItemModel(username: defaultUsername, text: "Some text 3", attachments: [
            ])
        
        let i4 = FeedItemModel(username: defaultUsername, text: "Some text 4", attachments: [
            ])
        
        items = [i1, i2, i3, i4]
    }
    
    func addNew(item: FeedItemModel)  {
        items.append(item)
    }
}
