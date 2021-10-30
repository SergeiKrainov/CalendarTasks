//
//  AlertOk.swift
//  CalendarTasks
//
//  Created by Sergey on 28.10.2021.
//

import UIKit

extension UIViewController {
    
    func alertOk(title: String) {
        
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(ok)

        present(alert, animated: true, completion: nil)
    }
}
