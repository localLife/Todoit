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
    //let defaults = UserDefaults.standard //sets up std user defaults space

    override func viewDidLoad() {
        super.viewDidLoad()
       
        //Begin Hardcode
        let newItem = Item(); newItem.title = "Find Chocolate"; itemArray.append(newItem)
        let newItem2 = Item(); newItem2.title = "Buy Chocolate"; itemArray.append(newItem2)
        let newItem3 = Item(); newItem3.title = "Eat Chocolate"; itemArray.append(newItem3)
        //End Hardcode
        
        //Create Array of items from UserDefaults (1st line works only if User Defaults not empty.
        //itemArray = defaults.array(forKey: "TodoListArray") as! [String]
        /*if let items = defaults.array(forKey: "TodoListArray")
            as? [Item]  {
            itemArray = items
        }*/

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
        tableView.reloadData()  //reload to include changes
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
            
            //save updated itemArray to userdef space after add
            /*self.defaults.set(self.itemArray, forKey: "TodoListArray")
            self.tableView.reloadData()  //reload to include newly added data*/

        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

