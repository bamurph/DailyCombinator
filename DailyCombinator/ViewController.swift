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
    @IBOutlet weak var itemID: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.rac_text <~ viewModel.titleText
        textView.rac_text <~ viewModel.itemText
        commentView.rac_text <~ viewModel.commentText
        viewModel.itemID <~ itemID.rac_text

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


}

