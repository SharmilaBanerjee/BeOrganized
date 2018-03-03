//
//  ViewController.swift
//  BeOrganized
//
//  Created by Sharmila Banerjee on 02/03/18.
//  Copyright © 2018 Sharmila Banerjee. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var toDoItemsArray  = [Item]()
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Update Raincan"
        toDoItemsArray.append(newItem)
        
        let newItem1 = Item()
        newItem1.title = "Babbie Vaccine"
        toDoItemsArray.append(newItem1)
        
        let newItem2 = Item()
        newItem2.title = "Buy Veggies"
        toDoItemsArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "DMart"
        toDoItemsArray.append(newItem3)
        
//        if let items = defaults.array(forKey: "toDoItemsArray") as? [String] {
//            toDoItemsArray = items
//        }
   
    }
 
    //TableView DataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItemsArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let itemRow = toDoItemsArray[indexPath.row]
        cell.textLabel?.text = itemRow.title
        //using terneray operator
        cell.accessoryType = itemRow.done ? .checkmark : .none
        return cell
    }
    
    //Tableview Delegate mathods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        toDoItemsArray[indexPath.row].done = !toDoItemsArray[indexPath.row].done

        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    // Add new Items in the list
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New To Do Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //action that will happen after we press add
            let newItem = Item()
            newItem.title = textField.text!
            self.toDoItemsArray.append(newItem)
            self.defaults.set(self.toDoItemsArray, forKey: "toDoItemsArray")
            self.tableView.reloadData()
        }
        
        // adding text field to alert
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        
        //adding action to alert
        alert.addAction(action)
        
        //presentation of the alert
        present(alert, animated: true, completion: nil)
    }
    

}

