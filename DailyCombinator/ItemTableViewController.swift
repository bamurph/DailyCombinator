//
//  ItemTableViewController.swift
//  DailyCombinator
//
//  Created by Ben Murphy on 10/18/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result

class ItemTableViewController: UITableViewController {

    private let viewModel = ItemTableViewModel()
    // TODO: - Inject itemID via storyboard segue
    private let itemID = MutableProperty<Int>(12734671)
    private let dicts = MutableProperty<[NSDictionary]>([])

    override func viewDidLoad() {
        super.viewDidLoad()

        bindViewModel()

        viewModel.dicts.producer.on(value: {print($0.count)}).start()
        viewModel.dicts.producer.startWithValues { dicts in
            print(dicts.count)
        }

        dicts.producer.startWithValues {
            print($0.count)
        }
    }

    private func bindViewModel() {
        dicts <~ viewModel.dicts.map { $0 }
        viewModel.fetchItemTree(itemID.value)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dicts.value.count
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
