//
//  DeleteItemAlert.swift
//  Pictures
//
//  Created by Миша on 10.03.2022.
//

import UIKit

class DeleteItemAlert{
    
    func showDeleteAlert(vc: UIViewController, itemUrl: URL, completion: @escaping (Bool)->()) {
        let alert = UIAlertController(
            title: "Do you want to delete",
            message: nil,
            preferredStyle: .alert)
        
        
        let cancel = UIAlertAction(
            title: "Cancel",
            style: .cancel,
            handler: nil)

        
        let create = UIAlertAction(
            title: "Delete",
            style: .destructive) { action in
                self.removeItem(itemUrl: itemUrl)
                completion(true)
            }
        
        alert.addAction(create)
        alert.addAction(cancel)
        vc.present(alert, animated: true, completion: nil)
    }


    private func removeItem(itemUrl: URL){
        
        if FileManager.default.fileExists(atPath: itemUrl.path)
        {
            try! FileManager.default.removeItem(atPath: itemUrl.path)
        } else {
            print("File not found")
        }
    }
}
