//
//  HNViewModel.swift
//  DailyCombinator
//
//  Created by Ben Murphy on 10/5/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

import Foundation
import ReactiveSwift
import ReactiveCocoa
import Firebase

class HNViewModel {

    let newsService = HNService()
    let itemID = MutableProperty<String>("121003")


    let newsSubscriber = Observer<NSDictionary, NSError>(value: { print("\($0)") })
    let response = MutableProperty<NSDictionary>(NSDictionary())
    let titleText = MutableProperty<String>("")
    let commentText = MutableProperty<String>("")
    let itemText = MutableProperty<String>("")

    init() {
        itemID.producer
            .filter { $0.characters.count > 0 }
            .observe(on: QueueScheduler.main).start {
                guard let id = Int($0.value!) else { return }
                self.newsService.signalForItem(id)
                    .observe(on: QueueScheduler.main).start {
                        guard let r = $0.value else { return }
                        self.commentText.value = r.value(forKey: "comment") as? String ?? ""
                        self.titleText.value = r.value(forKey: "title") as? String ?? ""
                        self.itemText.value = r.value(forKey: "text") as? String ?? ""
                }

        }
    }
    
}

