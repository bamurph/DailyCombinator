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

    func signalForItem(_ id: Int) -> SignalProducer<NSDictionary, NSError> {
        return SignalProducer { sink, disposable in

            self.itemRef(id)?.observe(.value, with: { snapshot in
                guard let itemDict = snapshot?.value as? NSDictionary
                    else { return sink.send(error: HNError.Canceled.toError()) }
                sink.send(value: itemDict)
                sink.sendCompleted()
            })
        }
    }

}
