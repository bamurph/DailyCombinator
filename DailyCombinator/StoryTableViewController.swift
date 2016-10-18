//
//  StoryTableViewController.swift
//  DailyCombinator
//
//  Created by Ben Murphy on 10/12/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result

class StoryTableViewController: UITableViewController {

    private let viewModel = StoryTableViewModel()
    private let storyCellIdentifier = "StoryCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(refreshControlTriggered), for: .valueChanged)


        
        self.tableView.contentInset.top = 20

        bindViewModel()
    }

    // MARK: - Bindings
    private func bindViewModel() {
        viewModel.topStories.signal
            .observe(on: UIScheduler())
            .observeValues { [weak self] stories in
                print("Table view reloading data")
                self?.refreshControl?.endRefreshing()
                self?.tableView.reloadData()
        }
        viewModel.refreshObserver.send(value: ())
    }

    // MARK: - User Interaction
    func refreshControlTriggered() {
        viewModel.refreshObserver.send(value: ())
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return viewModel.numberOfSections()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.numberOfStoriesInSection(section: section)
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: storyCellIdentifier, for: indexPath)

        // Configure the cell...
        //print(indexPath.item)
        cell.textLabel?.text = viewModel.storyTitleAtIndexPath(indexPath: indexPath)
        return cell
    }


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
