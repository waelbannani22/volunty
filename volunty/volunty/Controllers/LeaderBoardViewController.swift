//
//  LeaderBoardViewController.swift
//  volunty
//
//  Created by wael bannani on 15/11/2021.
//

import UIKit

class LeaderBoardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let alert = UIAlertController(title: "hi ", message: "coming soon stay tuned!", preferredStyle: .alert)
        let action = UIAlertAction(title: "ok", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert,animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
