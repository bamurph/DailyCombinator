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
                .on(value: { dict in
                    // If there are no kids, send the item
                    guard let kidsIDs = dict.value(forKey: "kids") as? [Int] else {
                        sink.send(value: HNItem.from(dict))
                        return
                    }

                    // If there are kids, build up the tree recursively
                    var item = HNItem.from(dict)


                    let kidsSignals = kidsIDs.map { self.itemTreeSignal($0) }
                    let kidsProducers: SignalProducer<SignalProducer<HNItem, NoError>, NoError> = SignalProducer(values: kidsSignals)
                    let merged: SignalProducer<HNItem, NoError> = kidsProducers.flatten(.merge)
                    merged.startWithSignal { observer, disposable in
                            observer.observeValues( { kid in
                                item.kids.append(kid)
                                print(item)
                            })
                            observer.observeCompleted {
                                sink.send(value: item)
                                print(item)
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

