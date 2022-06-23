//
//  PasswordViewModel.swift
//  Pictures
//
//  Created by Миша on 23.06.2022.
//

import UIKit

class PasswordViewModel: LoginViewModelProtocol {
    
    // MARK: - initialise Elements
    var view = LoginView()
    var navigation = UIViewController()
    
    var firstTryNewPassword: String?
    private lazy var loginIsValid = true
    private lazy var passwordIsValid = false

    
    // MARK: - Life cycle
    init(){
        setupDelegates()
        
        view.actionButton.addTarget(self, action: #selector(targetButtonTapped), for: .touchUpInside)
        view.passwordTextField.becomeFirstResponder()
    }
    
    // MARK: - Private Methods
    
    @objc
    func targetButtonTapped(){
    }
}

// MARK: - TextFields' delegate
extension PasswordViewModel {
    
    private func setupDelegates(){
        view.loginTextField.textFieldDelegate = { [weak self] text in
            guard let self = self else {return}
            
            self.loginIsValid = text.loginIsValid()
            self.view.actionButton.isValid = self.loginIsValid && self.passwordIsValid
        }
        
        view.passwordTextField.textFieldDelegate = { [weak self] text in
            guard let self = self else {return}
            
            self.passwordIsValid = text.passwordIsValid()
            self.view.actionButton.isValid = self.loginIsValid && self.passwordIsValid
            self.view.isValidPasswordLabel.isValid = self.passwordIsValid
        }
        
        
        view.loginTextField.textFieldClearAction = { [weak self] in
            guard let self = self else {return}
            
            self.loginIsValid = false
            self.view.actionButton.isValid = self.loginIsValid && self.passwordIsValid
        }
        
        view.passwordTextField.textFieldClearAction = { [weak self] in
            guard let self = self else {return}
            
            self.passwordIsValid = false
            self.view.actionButton.isValid = self.loginIsValid && self.passwordIsValid
            self.view.isValidPasswordLabel.isValid = self.passwordIsValid
        }
        
        view.loginTextField.textFieldShouldReturnAction = { [weak self] in
            guard let self = self else {return}
            
            if self.view.actionButton.isEnabled {
                self.targetButtonTapped()
            }
        }
        
        view.passwordTextField.textFieldShouldReturnAction = { [weak self] in
            guard let self = self else {return}
            
            if self.view.actionButton.isEnabled {
                self.targetButtonTapped()
            }
        }
    }
}
