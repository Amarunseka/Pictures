//
//  LoginViewController.swift
//  Pictures
//
//  Created by Миша on 21.06.2022.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - initialise Elements
    private var viewModel: LoginViewModelProtocol

    // MARK: - Life cycle
    override func loadView() {
        super.loadView()
        view = viewModel.view
    }
    
    init(viewModel: LoginViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.navigation = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
