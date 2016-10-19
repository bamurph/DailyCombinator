//
//  HNItem.swift
//  DailyCombinator
//
//  Created by Ben Murphy on 10/11/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

import Foundation

struct HNItem {
    let id: Int
    let parent: Int?
    var kids: [Int]
    let text: String?

    init(from dict: NSDictionary) {
        self.id = dict.value(forKey: "id") as! Int
        self.kids = dict.value(forKey: "kids") as? [Int] ?? []
        self.parent = dict.value(forKey: "parent") as? Int
        self.text = dict.value(forKey: "text") as? String

    }

    mutating func matchKids(from: [HNItem]) {

    }

}



