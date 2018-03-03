//
//  TodoListViewController.swift
//  BeOrganized
//
//  Created by Sharmila Banerjee on 02/03/18.
//  Copyright © 2018 Sharmila Banerjee. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {

    var toDoItemsArray  = [Item]()
    var selectedCategory : Category? {
        didSet {
            print("Came to destinationVC")
            loadData()
        }
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
 
    //MARK - TableView DataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItemsArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let itemRow = toDoItemsArray[indexPath.row]
        cell.textLabel?.text = itemRow.title
        
        //MARK - using terneray operator
        cell.accessoryType = itemRow.done ? .checkmark : .none
        return cell
    }
    
    //MARK - Tableview Delegate mathods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        toDoItemsArray[indexPath.row].done = !toDoItemsArray[indexPath.row].done

        saveData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //MARK -  Add new Items in the list
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New To Do Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //MARK - action that will happen after we press add

            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            newItem.parentCategory = self.selectedCategory
            self.toDoItemsArray.append(newItem)
            self.saveData()
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
    func saveData() {
        
        do {
           try  context.save()
        }catch {
            print("error enoding data into plist \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadData(with request : NSFetchRequest<Item> = Item.fetchRequest(), predicate : NSPredicate? = nil) {
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES[cd] %@", selectedCategory!.name!)
        if let additionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates : [categoryPredicate,additionalPredicate])
        } else {
            request.predicate = categoryPredicate
        }
    
        do {
            print("calling load function")
        toDoItemsArray = try context.fetch(request)
            print("after calling load function \(toDoItemsArray.count)")
        } catch {
            print ("Error in fethcing data \(error)")
        }
        tableView.reloadData()
    }
   
}
// MARK - Search Bar delegate Mathods
extension TodoListViewController : UISearchBarDelegate {
    
    //MARK - delegate method when search key is pressed
   func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("test entered in search bar \(searchBar.text!)")
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
    loadData(with: request,predicate : request.predicate!)
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


