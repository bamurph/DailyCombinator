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

extension HNItemBase {
    var id: Int { get }
    var by: String? { get }
    var time: Date? { get }
}

protocol HasText {
    var text: String? { get }
}
