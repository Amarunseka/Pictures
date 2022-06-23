//
//  SimpleNoticeAlert.swift
//  Pictures
//
//  Created by Миша on 23.06.2022.
//

import UIKit

extension UIViewController {
    
    func showSimpleAlert(text: String) {
        
        let alert = UIAlertController(title: "Error", message: text, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(ok)
        present(alert, animated: true)
    }
}
