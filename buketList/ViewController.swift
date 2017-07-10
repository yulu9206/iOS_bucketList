//
//  ViewController.swift
//  buketList
//
//  Created by Lu Yu on 7/7/17.
//  Copyright © 2017 Lu Yu. All rights reserved.
//

import UIKit

class BucketListViewController: UITableViewController, AddItemTableViewControllerDelegate {
    var tasks = ["a","b","c","d"]
    override func viewDidLoad() {
        super.viewDidLoad()
        print ("Loaded")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "EditItemSegue", sender: indexPath)
        print (indexPath)
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        tasks.remove(at: indexPath.row)
        tableView.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItemSegue" {
            print ("selected add")
            let navigationController = segue.destination as! UINavigationController
            let addItemTableController = navigationController.topViewController as! AddItemTableViewController
            addItemTableController.delegate = self
            
        } else if segue.identifier == "EditItemSegue" {
            print ("selected an edit")
            let navigationController = segue.destination as! UINavigationController
            let addItemTableController = navigationController.topViewController as! AddItemTableViewController
            addItemTableController.delegate = self
            
            let indexPath = sender as! NSIndexPath
            let item = tasks[indexPath.row]
            addItemTableController.item = item
            addItemTableController.indexPath = indexPath
        }

    }
    func cancelButtonPressed(by controller: AddItemTableViewController) {
        print("cancel button pressed controller")
        dismiss(animated: true, completion: nil)
    }
    func itemSaved(by controller: AddItemTableViewController, with text: String, at indexPath: NSIndexPath?) {
        if let ip = indexPath {
            tasks[ip.row] = text
        } else {
            tasks.append(text)
        }
        print("save button pressed from controller : \(text)")
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
}

