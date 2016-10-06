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

    let newsSubscriber = Observer<NSDictionary, NSError>(value: { print("\($0)") })
    let response = MutableProperty<NSDictionary>(NSDictionary())
    let titleText = MutableProperty<String>("")

    init() {
        
        newsService.signalForItem(8888)
            .observe(on: QueueScheduler.main).start { r in
                guard r.value != nil else { return }
                self.response.value = r.value!
                self.titleText.value = r.value!.value(forKey: "title") as! String
        }
    }



}

