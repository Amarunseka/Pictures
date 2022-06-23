//
//  SuccessChangePasswordAlert.swift
//  Pictures
//
//  Created by Миша on 23.06.2022.
//

import UIKit

extension UIViewController {
    
    func SuccessChangePasswordAlert(text: String, completion: @escaping (()->())) {
        
        let alert = UIAlertController(title: "Success", message: text, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) { action in
            completion()
        }
        
        alert.addAction(ok)
        present(alert, animated: true)
    }
}
