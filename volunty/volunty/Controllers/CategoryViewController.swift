//
//  CategoryViewController.swift
//  volunty
//
//  Created by wael bannani on 7/11/2021.
//

import UIKit

class CategoryViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Mcell")
        let contentView = cell?.viewWithTag(0)
        
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var ListeCategory: UICollectionView!
  
  
}
