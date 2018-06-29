//
//  TodoListViewController.swift
//  Todoit
//
//  Created by Nicole Blackwell on 6/25/18.
//  Copyright © 2018 Nicole Blackwell. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    //Array of Items
    var itemArray = [Item]()
    
    //Creating own plist with FileManager singleton
    let dataFilePath = FileManager.default.urls(for: .documentDirectory,
        in: .userDomainMask).first?.appendingPathComponent("Items.plist")
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Begin Hardcode
        let newItem = Item(); newItem.title = "Find Chocolate"; itemArray.append(newItem)
        let newItem2 = Item(); newItem2.title = "Buy Chocolate"; itemArray.append(newItem2)
        let newItem3 = Item(); newItem3.title = "Eat Chocolate"; itemArray.append(newItem3)
        //End Hardcode
    }

    //MARK - Tableview Data Source Methods
    //How many rows
    //What cells should display
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.complete ? .checkmark : .none  //ternary operator
        return cell
    }
    
    //MARK - Tableview Delegate Methods
    
    //Select and deselect items (print in Console
    //Check/Uncheck selected items
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //highlight for flash, then deselect
        //Flips checkmark value, but still needs to be reloaded
        //reloads changes to tableview
        tableView.deselectRow(at: indexPath, animated: true)
        itemArray[indexPath.row].complete = !itemArray[indexPath.row].complete
        saveItems()
    }
    
    //MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        //Add UIAlert popup so user can type in new item for list
        
        let newItem = Item()
        
        var textField = UITextField() //constructor
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            self.saveItems()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    // MARK - Model Manipulation Methods
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Help", error)
        }
        tableView.reloadData()
    }
}

