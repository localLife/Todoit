//
//  TodoListViewController.swift
//  Todoit
//
//  Created by Nicole Blackwell on 6/25/18.
//  Copyright © 2018 Nicole Blackwell. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = ["Find Chocolate", "Buy Chocolate", "Eat Chocolate", "Make Candy"]
    let defaults = UserDefaults.standard //sets up std user defaults space

    override func viewDidLoad() {
        super.viewDidLoad()
        //Next line would work if TodoListArray exists in userDefaults, but will crash if not
        //So commented and changed to better option
        //itemArray = defaults.array(forKey: "TodoListArray") as! [String]
        if let items = defaults.array(forKey: "TodoListArray")
            as? [String]  {
            itemArray = items
        }
    }

    //MARK - Tableview Data Source Methods
    //How many rows
    //What cells should display
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    //MARK - Tableview Delegate Methods
    
    //Select and deselect items (print in Console
    //Check/Uncheck selected items
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected - "+itemArray[indexPath.row])
        //highlight for flash, then deselect
        tableView.deselectRow(at: indexPath, animated: true)
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
    }
    
    //MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        //Add UIAlert popup so user can type in new item for list
        
        var textField = UITextField() //constructor
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            self.itemArray.append(textField.text!)
            //save updated itemArray to userdef space after add
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            self.tableView.reloadData()  //reload to include newly added data
            print(self.itemArray)
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

