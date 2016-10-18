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

    func itemTreeSignal(id: Int) -> SignalProducer<Node<Int>, NoError> {
        return SignalProducer<Node<Int>, NoError> { sink,_ in
            self.newsService.signalForItem(id)
                .on(value: { dict in
                    let kidsIDs = dict.value(forKey: "kids") as? [Int] ?? []
                    let node = Node(value: id, kids: kidsIDs)
                    sink.send(value: node)
                    let kidsSignals = kidsIDs.map { self.itemTreeSignal(id: $0) }
                    let kidsProducers: SignalProducer<SignalProducer<Node<Int>, NoError>, NoError> = SignalProducer(values: kidsSignals)
                    let merged: SignalProducer<Node<Int>, NoError> = kidsProducers.flatten(.merge)
                    merged.startWithValues { node in
                        sink.send(value: node)
                    }
                }).start()
        }
    }
}

