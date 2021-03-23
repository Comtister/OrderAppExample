//
//  MenuViewController.swift
//  OrderApp
//
//  Created by Oguzhan Ozturk on 9.03.2021.
//

import UIKit

class MenuViewController: UITableViewController {

   
    
    let category : String
    
    let menuController : MenuController = MenuController()
    
    var menuItems : [MenuItem] = [MenuItem]()
    
    init?(coder : NSCoder , category : String){
        
        self.category = category
        super.init(coder: coder)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = category

        menuController.fetchMenuItems(forCategory: category, completion: { result in
            
            switch result{
            
            case .success(let items) : self.updateUI(menuItems: items)
            
            case .failure(let error):
                print(error.localizedDescription)
            }
            
            
        })
        
        print(xxx)
        
        
    }
    
   
    
    func updateUI(menuItems : [MenuItem]) ->Void{
        
        DispatchQueue.main.async {
            self.menuItems = menuItems
            self.tableView.reloadData()
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return menuItems.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "secilenCell", for: indexPath)
        
        self.configure(cell: cell, indexPath: indexPath)
        
        return cell
        
    }
    
    
    func configure(cell : UITableViewCell , indexPath : IndexPath){
        
        let menuItem = menuItems[indexPath.row]
        cell.textLabel?.text = menuItem.name
        cell.detailTextLabel?.text = "$\(menuItem.price)"
        
    }

    
}
