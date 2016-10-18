//
//  ViewController.swift
//  DailyCombinator
//
//  Created by Ben Murphy on 10/5/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

import UIKit
import ReactiveCocoa
import Firebase
import ReactiveSwift

class ViewController: UIViewController {

    let viewModel = HNViewModel()

    @IBOutlet weak var maxID: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        maxID.rac_text <~ viewModel.maxID

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


}

