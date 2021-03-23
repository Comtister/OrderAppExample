//
//  CategoryViewController.swift
//  OrderApp
//
//  Created by Oguzhan Ozturk on 9.03.2021.
//

import UIKit

class CategoryViewController: UITableViewController {

    let menuController : MenuController = MenuController()
    var categories : [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        menuController.fetchCategories(completion: { result in
            
            
            switch result{
            
            
            case .success(let categories): self.updateUI(with: categories)
            
            case .failure(let error): self.displayError(error, title: "Hata")
                
            }
            
        })
        
        
    }
    
    func updateUI(with categories : [String]) -> Void{
        
        DispatchQueue.main.async {
            self.categories = categories
            self.tableView.reloadData()
        }
        
    }
    
    func displayError(_ error : Error , title : String) -> Void{
        
        DispatchQueue.main.async {
            print("Hata")
        }
        
    }
    
    func showMenu(segue : UIStoryboardSegue){
        
        
        
    }

    @IBSegueAction func showMenu(_ coder: NSCoder, sender: Any?) -> MenuViewController? {
        
        guard let cell = sender as? UITableViewCell , let indexPath = tableView.indexPath(for: cell) else{
            return nil
        }
        
        let category = categories[indexPath.row]
        
        return MenuViewController(coder: coder, category: category)
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "kategoriCell", for: indexPath)
        
        configureCell(cell : cell, forCategoryRowAt: indexPath)
        
        return cell
        
    }
    

    func configureCell(cell : UITableViewCell , forCategoryRowAt indexPath : IndexPath){
        
        let category = categories[indexPath.row]
        cell.textLabel?.text = category.capitalized
        
    }
    
}
