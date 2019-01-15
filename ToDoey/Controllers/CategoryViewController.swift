// Leaves are not very nutritious. The slothes way of compensatiting for that is not to eat more but to do less.
//  CategoryViewController.swift
//  ToDoey
//
//  Created by Tom Creaven on 11/01/2019.
//  Copyright © 2019 Tom Creaven. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var categoryArray: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //print (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        loadCategories()
    }
    
    

    //MARK: - TableView Datasource Methods
    // Display
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categoryArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        
        cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No Categories Added Yet"
        
        return cell
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        // Here we declare an instance of the UITextField datatype so we can assign the PopUp text field to a global variable for this method. It allows us to abstract the textfield created later to a higher level
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        // Creates an action inside the UIAlert e.g. in this case the button that says add category
        let action = UIAlertAction(title: "Create Category", style: .default) { (action) in
            
            // What happens when user clicks add category button inside UIAlert
            if textField.text! != ""{
                let newCategory = Category()
                newCategory.name = textField.text!
                self.save(category: newCategory)
            }
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Category"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    
   
    
    //MARK: - Model Manipulation Methods
    
    func save(category: Category){
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving content \(error)")
        }
        tableView.reloadData()
    }
    

    func loadCategories(){
        
        categoryArray = realm.objects(Category.self)
        tableView.reloadData()
        
    }
    
    
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    // if we had more than one viewController we might have an if statement in the below function so as to only perform it if the right segue was pressed
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        //using an if let here because the indexPathForSelectedRow is an optional value (you might not have selected a row), though it's not likely to be called unless you had selected a row since it's only performing the segue when the didselectRow is called...but still it doesn't hurt to be safe
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray?[indexPath.row]
        }
        
        
    }
    
    
    

}


