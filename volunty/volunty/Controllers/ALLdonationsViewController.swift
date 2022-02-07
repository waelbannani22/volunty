//
//  ALLdonationsViewController.swift
//  volunty
//
//  Created by wael bannani on 26/12/2021.
//

import UIKit
import SwiftyJSON
class ALLdonationsViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
  
    //var
    var size = 0
    //widgets
    @IBOutlet weak var TV: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isTranslucent = false
      //  self.tabBarController?.tabBar.backgroundColor = UIColor(named: "323B61")
       
           
        //let defaults = UserDefaults.standard
        //let id = defaults.value(forKey: "recruiterId") as! String
        PostingViewModel.instance.fetchDonationAll{
            result in
            switch result {
            case .success(let json):
                let json1 = JSON(json)
                print(json1)
               
                self.size = json1["donation"].count
                print("size",self.size)
               
                self.TV.reloadData()
                
                
            case .failure(let value):
                print(value.localizedDescription)
            }
        }
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mCell", for: indexPath)
        let contentView = cell.contentView
        cell.contentView.layer.cornerRadius = 20
        cell.contentView.layer.masksToBounds = true
        
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.3
        cell.layer.shadowRadius = 4.0
        cell.layer.masksToBounds = false
        cell.layer.shadowOffset = CGSize(width: 0, height: 2)
        let imageV = contentView.viewWithTag(1) as! UIImageView
        let name = contentView.viewWithTag(2) as! UILabel
            //api
       // let defaults = UserDefaults.standard
       // let id = defaults.value(forKey: "recruiterId") as! String
        print("size initiiale",self.size)
        PostingViewModel.instance.fetchDonationAll{
            result in
            switch result {
            case .success(let json):
                let json1 = JSON(json)
                print(json1)
       
                let img = json1["donation"][indexPath.row]["photo"].string
                let lab = json1["donation"][indexPath.row]["name"].string
               
                ImageLoader.shared.loadImage(
                 identifier: img!,
                    url: "http://localhost:8885/img/\(img!)",
                    completion: { image in
                        imageV.image = image!
                        
                    })
                name.text = lab!
            case .failure(let value):
                print(value.localizedDescription)
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "Segue", sender: indexPath.row)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Segue" {
            let index = sender as! Int
            let destination = segue.destination as! donateViewController
            destination.index = index
        }
    }

}
