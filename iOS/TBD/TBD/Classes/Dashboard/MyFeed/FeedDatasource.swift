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
    
    static let instance = FeedDatasource()
    
    private init() {
        let i1 = FeedItemModel(username: defaultUsername, text: "Some text 1", attachment: nil)
        
        let i2 = FeedItemModel(username: defaultUsername, text: "This constraint ties an element at zero points from the bottom layout guide: http://www.cureleukaemia.co.uk", attachment: nil)
        
        let i3 = FeedItemModel(username: defaultUsername, text: "Some text 3", attachment: nil)
        
        let i4 = FeedItemModel(username: defaultUsername, text: "Some text 4", attachment: nil)
        
        items = [i1, i2, i3, i4]
    }
    
    func addNew(item: FeedItemModel)  {
        items.append(item)
    }
}
