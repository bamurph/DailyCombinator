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

    static func from(_ dict: NSDictionary) throws -> HNItem {
        guard let id = dict.value(forKey: "id") as? Int else {
            throw HNITemError.noID
        }

        return HNItem.init(id: id,
                           parent: dict.value(forKey: "parent") as? Int,
                           kids: dict.value(forKey: "kids") as? [Int] ?? [],
                           text: dict.value(forKey: "text") as? String)
    }


    enum HNITemError: Error {
        case noID
    }
}

struct Node<T> {

}

