//
//  HNError.swift
//  DailyCombinator
//
//  Created by Ben Murphy on 10/5/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

import Foundation

enum HNError: Int {
    case Canceled = 0
    case NilResponse = 1

    func toError() -> NSError {
        return NSError(domain: "HNews", code: self.rawValue, userInfo: nil)
    }
}
