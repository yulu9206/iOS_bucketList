//
//  AddItemTableViewControllerDelegate.swift
//  buketList
//
//  Created by Lu Yu on 7/7/17.
//  Copyright © 2017 Lu Yu. All rights reserved.
//

import Foundation

protocol AddItemTableViewControllerDelegate: class {
    func itemSaved(by controller: AddItemTableViewController, with text:String, at indexPath: NSIndexPath?)
    func cancelButtonPressed(by controller: AddItemTableViewController)
}
