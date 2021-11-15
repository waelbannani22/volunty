//
//  DateSelectionViewController.swift
//  volunty
//
//  Created by wael bannani on 9/11/2021.
//

import UIKit

class DateSelectionViewController: UIViewController {

    var selectedDate = ""
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.maximumDate = Date()
        
        if selectedDate.count != 0{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let date = dateFormatter.date(from: selectedDate)
            
            datePicker.date = date!
            
        }
        
    }
    

    @IBAction func cancelTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func doneTapped(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/M/YYYY"
        let somedateString = dateFormatter.string(from: datePicker.date)
        NotificationCenter.default.post(name: Notification.Name("dateAdded"), object: somedateString)
        
        dismiss(animated: true, completion: nil)
    }
    
    

}
