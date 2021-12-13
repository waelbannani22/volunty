//
//  CategoryViewController.swift
//  volunty
//
//  Created by wael bannani on 7/11/2021.
//

import UIKit

class CategoryViewController: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource{
   
    
   
    //var
    let categoryNames = ["ANIMAL", "CHILDREN", "COMMUNITY", "DISABILITY", "EDUCATION", "ENVIRONMENT", "HEALTH", "HOMELESS", "SENIOR"]
    //widgets
   

    @IBOutlet weak var viewCollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewCollection.delegate = self
        viewCollection.dataSource = self

        // Do any additional setup after loading the view.
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mCell", for: indexPath)
        let contentView = cell.contentView
        let image = contentView.viewWithTag(1) as! UIImageView
        let name = contentView.viewWithTag(2) as! UILabel
        image.image = UIImage(named: "\(categoryNames[indexPath.row])_i.png")
        name.text = categoryNames[indexPath.row]
        cell.contentView.layer.cornerRadius = 20
        cell.contentView.layer.masksToBounds = true
        
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.3
        cell.layer.shadowRadius = 4.0
        cell.layer.masksToBounds = false
        cell.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 28 - 28 - 10 - 10) / 2
        return CGSize(width: width, height: UIScreen.main.bounds.height * 0.3)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "Segue", sender: indexPath.row)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Segue" {
            let index = sender as! Int
            let destination = segue.destination as! ExperiencesViewController
            destination.categoryName = categoryNames[index]
        }
    }
    

   
    
    
  
  
}
