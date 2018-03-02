//
//  ViewController.swift
//  BeOrganized
//
//  Created by Sharmila Banerjee on 02/03/18.
//  Copyright © 2018 Sharmila Banerjee. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var toDoItemsArray  = ["Update Raincan","Babbie Vaccine"]
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        if let items = defaults.array(forKey: "toDoItemsArray") as? [String] {
            toDoItemsArray = items
        }
   
    }
 
    //TableView DataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItemsArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = toDoItemsArray[indexPath.row]
        return cell
    }
    
    //Tableview Delegate mathods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you have selected " + toDoItemsArray[indexPath.row])
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    // Add new Items in the list
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New To Do Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //action that will happen after we press add
            self.toDoItemsArray.append(textField.text!)
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

