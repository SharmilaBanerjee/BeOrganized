//
//  CategoryTableViewController.swift
//  BeOrganized
//
//  Created by Sharmila Banerjee on 03/03/18.
//  Copyright © 2018 Sharmila Banerjee. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {

    var categoryArray  = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        
    }

    // MARK - Table View Data Source methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let itemRow = categoryArray[indexPath.row]
        cell.textLabel?.text = itemRow.name
        
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
            destinationVC.selectedCategory = categoryArray[selectedIndexPath.row]
            print("from category VC")
        }
    }
    
    
    // MARK - Data Manipulation methods
    func saveData() {
        
        do {
            try  context.save()
        }catch {
            print("error enoding data into plist \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadData(with request : NSFetchRequest<Category> = Category.fetchRequest()) {
        do {
            categoryArray = try context.fetch(request)
            } catch {
            print ("Error in fethcing data \(error)")
        }
        tableView.reloadData()
    }
    
    // MARK - Add new category
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //MARK - action that will happen after we press add
            
            let newItem = Category(context: self.context)
            newItem.name = textField.text!
            self.categoryArray.append(newItem)
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
    

}
