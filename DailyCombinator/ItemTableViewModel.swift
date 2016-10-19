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
    let itemList = MutableProperty<[HNItem]>([])



    init() {

    }

    func itemTreeSignal(_ id: Int) -> SignalProducer<HNItem, NoError> {
        return SignalProducer<HNItem, NoError> { sink,_ in
            self.newsService.signalForItem(id)
                .map { try? HNItem.from($0) }
                .skipNil()
                .on(value: { item in
                    sink.send(value: item)
                    let kidsSignals = item.kids.map { self.itemTreeSignal($0) }
                    let kidsProducers: SignalProducer<SignalProducer<HNItem, NoError>, NoError> = SignalProducer(values: kidsSignals)
                    let merged: SignalProducer<HNItem, NoError> = kidsProducers.flatten(.merge)

                    merged.startWithSignal { (observer, disposable) -> () in
                        observer.observeValues( { item in
                            sink.send(value: item)
                        })
                        observer.observeCompleted {
                            sink.sendCompleted()
                        }
                    }
                })
                .start()
        }
    }

    func fetchItemTree(_ id: Int) {
        itemTreeSignal(id)
            .on(starting: { self.itemList.value.removeAll() })
            .on(value: { item in
                self.itemList.value.append(item)
            })
            .start()
    }




}

