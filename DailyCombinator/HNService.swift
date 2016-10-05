//
//  HNService.swift
//  DailyCombinator
//
//  Created by Ben Murphy on 10/5/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

import Foundation
import Firebase
import ReactiveCocoa
import ReactiveSwift

class HNService {
    private let rootRef = Firebase(url: "https://hacker-news.firebaseio.com/v0/")

    func itemRef(_ id: Int) -> Firebase? {
        return rootRef?.child(byAppendingPath: "item/\(id)")
    }

    func requestAccessToItem(_ id: Int) -> SignalProducer<FDataSnapshot, NSError> {


        return SignalProducer {
            (observer: Observer<FDataSnapshot, NSError>, _) in
            self.itemRef(id)?.observe(.value, with: { snapshot in
                guard let s = snapshot
                    else { return observer.send(error: HNError.Canceled.toError()) }
                observer.send(value: s)
                observer.sendCompleted()
            })
        }
    }
}
