//
//  HNItem.swift
//  DailyCombinator
//
//  Created by Ben Murphy on 10/11/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

import Foundation

protocol HNItemBase {
    var id: Int { get }
    var by: String? { get }
    var time: Date? { get }
}

protocol HasText {
    var text: String? { get }
}

struct HNStory: HNItemBase, HasText {
    internal var id: Int
    internal var by: String?
    internal var text: String?
    internal var time: Date?
}

struct HMTreeNode {
    let id: Int
    let kids: [HMTreeNode]?
}
