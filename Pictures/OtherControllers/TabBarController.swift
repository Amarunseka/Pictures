//
//  TabBarController.swift
//  Pictures
//
//  Created by Миша on 21.06.2022.
//

import UIKit

class TabBarController: UITabBarController {
    
    // MARK: - initialise Elements
    private let documentsURL = try! FileManager.default.url(
        for: .documentDirectory,
           in: .userDomainMask,
           appropriateFor: nil,
           create: false)
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupViews()
    }
    
    // MARK: - Private Methods
    private func setupTabBar() {
        tabBar.backgroundColor = .systemGray3
        tabBar.tintColor = .systemBlue
        tabBar.unselectedItemTintColor = .systemGray2
        tabBar.layer.borderColor = UIColor.systemBrown.cgColor
        tabBar.layer.borderWidth = 1
    }
    
    private func setupViews(){
        let filesVC = UINavigationController(rootViewController: FilesViewController(directoryURL: documentsURL))
        let settingsVC = SettingsViewController()
        
        setViewControllers([filesVC, settingsVC], animated: true)
        
        guard let items = tabBar.items else {return}
        items[0].title = "Files"
        items[0].image = UIImage(systemName: "folder.fill")
        
        items[1].title = "Settings"
        items[1].image = UIImage(systemName: "gear")
        
    }
    
}
