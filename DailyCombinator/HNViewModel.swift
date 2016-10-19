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
import Result

class HNViewModel {

    let newsService = HNService()
    let maxID = MutableProperty<String>("0")
    let itemID = MutableProperty<String>("121003")

    let topStories = MutableProperty<[NSDictionary]>([])
    let topStoryString = MutableProperty<String>("")
    let newsSubscriber = Observer<NSDictionary, NSError>(value: { print("\($0)") })
    let response = MutableProperty<NSDictionary>(NSDictionary())
    let titleText = MutableProperty<String>("")
    let commentText = MutableProperty<String>("")
    let itemText = MutableProperty<String>("")

    init() {
        itemID.producer
            .filter { $0.characters.count > 0 }
            .throttle(0.5, on: QueueScheduler.main)
            .observe(on: QueueScheduler.main).start {
                guard let id = Int($0.value!) else { return }
                self.newsService.signalForItem(id)
                    .observe(on: QueueScheduler.main).start {
                        guard let r = $0.value else { return }
//                        self.commentText.value = r.value(forKey: "comment") as? String ?? ""
//                        self.titleText.value = r.value(forKey: "title") as? String ?? ""
//                        self.itemText.value = r.value(forKey: "text") as? String ?? ""
                }

        }

        maxID <~ newsService.maxID.map { String($0) }



        newsService.storyIDs(type: .top)
            .on(value: { ids in
                self.newsService.signalForItems(ids: ids)
                    .observe(on: QueueScheduler.main)
                    .on(value: { self.topStoryString.value.append("\n\n \($0)") })
                    .take(first: 5)
                    .start()

            }).start()
    }
    
}
