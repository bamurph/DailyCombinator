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
    var kids: [HNItem]
    let text: String?

    static func from(_ dict: NSDictionary) -> HNItem {

        return HNItem.init(id: dict.value(forKey: "id") as! Int,
                           parent: dict.value(forKey: "parent") as? Int,
                           kids: [],
                           text: dict.value(forKey: "text") as? String)
    }



}



