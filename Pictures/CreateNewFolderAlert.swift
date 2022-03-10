//
//  CreateNewFolderAlert.swift
//  Pictures
//
//  Created by Миша on 09.03.2022.
//

import UIKit


class CreateNewFolderAlert{
    
    func showAlert(vc: UIViewController, parentURL: URL, completion: @escaping (Bool)->()) {
        let alert = UIAlertController(
            title: "Create new folder",
            message: nil,
            preferredStyle: .alert)
        
        
        let cancel = UIAlertAction(
            title: "Cancel",
            style: .destructive,
            handler: nil)

        
        let create = UIAlertAction(
            title: "Create",
            style: .default) { action in
                if let name = alert.textFields?.first?.text,
                   !name.isEmpty {
                    self.createNewFolder(name: name, parenURL: parentURL)
                    completion(true)
                }
            }
        
        alert.addTextField(configurationHandler: nil)
        alert.addAction(cancel)
        alert.addAction(create)
        vc.present(alert, animated: true, completion: nil)
    }


    private func createNewFolder(name: String, parenURL: URL){
        let newFolderPath = parenURL
            .appendingPathComponent(name)
        
        
        try! FileManager.default.createDirectory(
            at: newFolderPath,
            withIntermediateDirectories: true,
            attributes: nil)
    }
}
