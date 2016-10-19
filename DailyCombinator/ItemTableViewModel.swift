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
                .on(value: { item in
                    sink.send(value: item)
                    self.newsService.signalForItems(ids: item.kids)
                        .startWithSignal { observer, disposable in
                        observer.observeValues( { kid in
                            print(kid.id)
                            sink.send(value: kid)
                        })
                        observer.observeCompleted {
                            print("Completed")
                            sink.sendCompleted()
                        }
                    }
                })
                .start()
        }
    }

    func fetchItemTree(_ id: Int) {
        itemTreeSignal(id)
            .collect()
            .startWithValues { (value) in
                self.itemList.swap(value)
        }

    }




}

