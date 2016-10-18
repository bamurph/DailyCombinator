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

    func itemTreeSignal(id: Int) -> SignalProducer<NSDictionary, NoError> {
        return SignalProducer<NSDictionary, NoError> { sink,_ in
            self.newsService.signalForItem(id)
                .on(value: { dict in

                    let kidsIDs = dict.value(forKey: "kids") as? [Int] ?? []
                    sink.send(value: dict)
                    let kidsSignals = kidsIDs.map { self.itemTreeSignal(id: $0) }
                    let kidsProducers: SignalProducer<SignalProducer<NSDictionary, NoError>, NoError> = SignalProducer(values: kidsSignals)
                    let merged: SignalProducer<NSDictionary, NoError> = kidsProducers.flatten(.merge)
                    merged.startWithSignal { (observer, disposable) -> () in
                        observer.observeValues( { dict in
                            sink.send(value: dict)
                        })
                        observer.observeCompleted {
                            sink.sendCompleted()
                        }
                    }

                }).start()
        }
    }
}

