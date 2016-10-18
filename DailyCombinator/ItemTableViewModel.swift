//
//  ItemTableViewModel.swift
//  DailyCombinator
//
//  Created by Ben Murphy on 10/18/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

import Foundation
import ReactiveSwift
import ReactiveCocoa
import Result
import Firebase

class ItemTableViewModel {

    let newsService = HNService()
    let itemID = MutableProperty<Int>(0)

    init() {

    }

    func itemTreeSignal(id: Int) {
        //self.newsService.signalForItem
    }
}
