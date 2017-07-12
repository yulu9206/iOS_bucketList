//
//  ViewController.swift
//  buketList
//
//  Created by Lu Yu on 7/7/17.
//  Copyright © 2017 Lu Yu. All rights reserved.
//

import UIKit
import CoreData

class BucketListViewController: UITableViewController, AddItemTableViewControllerDelegate {
    var items = [BucketListItem]()
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    func fetchAllIems() {
        let itemRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "BucketListItem")
        do {
            // get the results by executing the fetch request we made earlier
            let results = try managedObjectContext.fetch(itemRequest)
            // downcast the results as an array of AwesomeEntity objects
            items = results as! [BucketListItem]
            // print the details of each item
            for item in items {
                print("\(item.text)")
            }
        } catch {
            // print the error if it is caught (Swift automatically saves the error in "error")
            print("\(error)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print ("Loaded")
        fetchAllIems()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].text
        return cell
    }
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "EditItemSegue", sender: indexPath)
        print (indexPath)
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        managedObjectContext.delete(item)
        do {
            try managedObjectContext.save()
        } catch {
            print("\(error)")
        }
        items.remove(at: indexPath.row)
        tableView.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let addItemTableController = navigationController.topViewController as! AddItemTableViewController
        addItemTableController.delegate = self
        
        if segue.identifier == "AddItemSegue" {
            print ("selected add")
//            let navigationController = segue.destination as! UINavigationController
//            let addItemTableController = navigationController.topViewController as! AddItemTableViewController
//            addItemTableController.delegate = self
            
        } else if segue.identifier == "EditItemSegue" {
            print ("selected an edit")
//            let navigationController = segue.destination as! UINavigationController
//            let addItemTableController = navigationController.topViewController as! AddItemTableViewController
//            addItemTableController.delegate = self
            
            let indexPath = sender as! NSIndexPath
            let item = items[indexPath.row]
            addItemTableController.item = item.text!
            addItemTableController.indexPath = indexPath
        }

    }
    func cancelButtonPressed(by controller: AddItemTableViewController) {
        print("cancel button pressed controller")
        dismiss(animated: true, completion: nil)
    }
    func itemSaved(by controller: AddItemTableViewController, with text: String, at indexPath: NSIndexPath?) {

        if let ip = indexPath {
            let item = items[ip.row]
            item.text = text
        } else {
            let item = NSEntityDescription.insertNewObject(forEntityName: "BucketListItem", into: managedObjectContext) as! BucketListItem
            item.text = text
            items.append(item)
        }
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
                print("Success")
            } catch {
                print("\(error)")
            }
        }
        print("save button pressed from controller : \(text)")
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
}

