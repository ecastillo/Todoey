//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Eric Castillo on 4/29/18.
//  Copyright © 2018 Eric Castillo. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categoryArray = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
    }
    
    //MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categoryArray[indexPath.row].name
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
    }
    
    //MARK: - TableView Manipulation Methods
    func loadCategories() {
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        do {
            categoryArray = try context.fetch(request)
        } catch {
            print("Error fetching Category request: \(error)")
        }

        tableView.reloadData()
    }

    func saveCategories() {
        do {
            try context.save()
        } catch {
            print("Error saving Category context: \(error)")
        }
        
        tableView.reloadData()
    }
    
    
    //MARK: - Add New Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var alertTextField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Enter a category name"
            alertTextField = textField
        }
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            let newCategory = Category(context: self.context)
            newCategory.name = alertTextField.text
            self.categoryArray.append(newCategory)
            self.saveCategories()
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    
}
