//
//  ViewController.swift
//  BeOrganized
//
//  Created by Sharmila Banerjee on 02/03/18.
//  Copyright © 2018 Sharmila Banerjee. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    let toDoItemsArray  = ["Update Raincan","Babbie Vaccine"]
    override func viewDidLoad() {
        super.viewDidLoad()
   
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
    

}

