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
import Result
class HNService {
    private let rootRef = Firebase(url: "https://hacker-news.firebaseio.com/v0/")

    let maxID = MutableProperty<Int>(0)


    func signalForItem(_ id: Int) -> SignalProducer<NSDictionary, NSError> {
        return SignalProducer { sink, disposable in
            let itemRef = self.rootRef?.child(byAppendingPath: "item/\(id)")

            itemRef?.observe(.value, with: { snapshot in
                guard let itemDict = snapshot?.value as? NSDictionary
                    else { return sink.send(error: HNError.NilResponse.toError()) }
                sink.send(value: itemDict)
                sink.sendCompleted()
            })
        }
    }

    func signalForItems(ids: [Int]) -> SignalProducer<NSDictionary, NoError> {
        let itemSignals = ids.map { signalForItem($0) }
        let producers: SignalProducer<SignalProducer<NSDictionary, NSError>, NoError> = SignalProducer(values: itemSignals)
        let merged: SignalProducer<NSDictionary, NSError> = producers.flatten(.merge)

        return merged.flatMapError { _ in .empty }


    }

    func maxIDUpdateTimer(interval: TimeInterval) -> Timer  {
        let maxIDRef = rootRef?.child(byAppendingPath: "maxitem")
        return Timer.init(timeInterval: interval, repeats: true) { _ in
            maxIDRef?.observe(.value, with: { snapshot in
                self.maxID.value = (snapshot?.value as? Int) ?? self.maxID.value
            })
        }
    }

    func storyIDs(type: HNStoryCollectionType) -> SignalProducer<[Int], NSError> {
        return SignalProducer { sink, disposable in
            let ref = self.rootRef?.child(byAppendingPath: type.rawValue)

            ref?.observe(.value, with: { snapshot in
                guard let itemArray = snapshot?.value as? NSArray
                    else { return sink.send(error: HNError.NilResponse.toError()) }

                sink.send(value: itemArray as! [Int])
                sink.sendCompleted()
            })
        }
    }


    init() {
        maxIDUpdateTimer(interval: 5.0).fire()
        
    }
}
