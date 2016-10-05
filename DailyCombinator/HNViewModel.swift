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

    let response = MutableProperty<NSDictionary>(NSDictionary())

    init() {
        newsService.requestAccessToItem(8888)
        .on(value: <#T##((FDataSnapshot) -> Void)?##((FDataSnapshot) -> Void)?##(FDataSnapshot) -> Void#>, failed: <#T##((NSError) -> Void)?##((NSError) -> Void)?##(NSError) -> Void#>, completed: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>, interrupted: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>, terminated: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>, disposed: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
    }
}
