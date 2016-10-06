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
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var commentView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.rac_text <~ viewModel.titleText.signal
        textView.rac_text


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


}

