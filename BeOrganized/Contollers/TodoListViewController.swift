//
//  TodoListViewController.swift
//  BeOrganized
//
//  Created by Sharmila Banerjee on 02/03/18.
//  Copyright © 2018 Sharmila Banerjee. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController {

    var toDoItems : Results<Item>?
    let realm = try! Realm()
    var selectedCategory : Category? {
        didSet {
            print("Came to destinationVC")
            loadData()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
 
    //MARK - TableView DataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        if let itemRow = toDoItems?[indexPath.row] {
        cell.textLabel?.text = itemRow.title
        
        //MARK - using terneray operator
        cell.accessoryType = itemRow.done ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No Items Added"
        }
        return cell
    }
    
    //MARK - Tableview Delegate mathods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = toDoItems?[indexPath.row] {
            do {
                try realm.write {
                    item.done = !item.done
                }
            } catch {
                print ("Error changing status of done \(error)")
            }
        }
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //MARK -  Add new Items in the list
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New To Do Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //MARK - action that will happen after we press add
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                    let newItem = Item()
                    newItem.title = textField.text!
                    newItem.createdDate = Date()
                     currentCategory.items.append(newItem)
                    }
                }catch {
                    print("Error adding item \(error)")
                }
           
            }
                self.tableView.reloadData()
        }
        
        //MARK -  adding text field to alert
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        
        //MARK - adding action to alert
        alert.addAction(action)
        
        //MARK - presentation of the alert
        present(alert, animated: true, completion: nil)
    }
   //MARK - Model functions
    
    func loadData() {
        
        toDoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)

        tableView.reloadData()
    }
   
}
// MARK - Search Bar delegate Mathods
extension TodoListViewController : UISearchBarDelegate {
    
    //MARK - delegate method when search key is pressed
   func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("test entered in search bar \(searchBar.text!)")
    
          toDoItems = toDoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "createdDate", ascending: true)
        tableView.reloadData()
    }
    
    //MARK - return to main page after clearing search text
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text!.count == 0 {
            loadData()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
        }
    }
    
}


