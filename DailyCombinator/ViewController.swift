//
//  ViewController.swift
//  DailyCombinator
//
//  Created by Ben Murphy on 10/5/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import Firebase

class ViewController: UIViewController {

    let viewModel = HNViewModel()
    let subscriber = Observer<FDataSnapshot, NSError>(value: { print("\($0)") })

    override func viewDidLoad() {
        super.viewDidLoad()

        newsService.requestAccessToItem(8000)
            .start(subscriber)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

