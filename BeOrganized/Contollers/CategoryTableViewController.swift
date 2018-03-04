//
//  CategoryTableViewController.swift
//  BeOrganized
//
//  Created by Sharmila Banerjee on 03/03/18.
//  Copyright © 2018 Sharmila Banerjee. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryTableViewController: UITableViewController {

    let realm = try! Realm()
    
    var categoryArray : Results<Category>?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("coming to category VC load method")
        loadData()
        
    }

    // MARK - Table View Data Source methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No Categories Added Yet"
        
        //MARK - using terneray operator
       // cell.accessoryType = itemRow.done ? .checkmark : .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("before perform segue")
        performSegue(withIdentifier: "toDoList", sender: self)
        print("after perform segue")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray?[selectedIndexPath.row]
            print("from category VC")
        }
    }
    
    
    // MARK - Data Manipulation methods
    func save(category : Category) {
        
        do {
            try  realm.write {
                realm.add(category)
            }
        }catch {
            print("error enoding data into plist \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadData() {
        categoryArray = realm.objects(Category.self)

        tableView.reloadData()
    }
    
    // MARK - Add new category
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //MARK - action that will happen after we press add
            
            let newItem = Category()
            newItem.name = textField.text!
            self.save(category: newItem )
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
    

}
