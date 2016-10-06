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
import ReactiveObjC
import Firebase

class ViewController: UIViewController {

    let viewModel = HNViewModel()

    @IBOutlet weak var titleLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        viewModel.titleText <~ titleLabel.rac_text
    }


}

