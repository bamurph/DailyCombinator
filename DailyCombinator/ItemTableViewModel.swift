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
    let dicts = MutableProperty<[NSDictionary]>([])



    init() {

    }

    func itemTreeSignal(_ id: Int) -> SignalProducer<NSDictionary, NoError> {
        return SignalProducer<NSDictionary, NoError> { sink,_ in
            self.newsService.signalForItem(id)
                .on(value: { dict in
                    let kidsIDs = dict.value(forKey: "kids") as? [Int] ?? []
                    sink.send(value: dict)
                    let kidsSignals = kidsIDs.map { self.itemTreeSignal($0) }
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

    func fetchItemTree(_ id: Int) {
        itemTreeSignal(id)
            .on(starting: { self.dicts.value.removeAll() })
            .on(value: { dict in
                self.dicts.value.append(dict)

            })
            .start()
    }

    


}

