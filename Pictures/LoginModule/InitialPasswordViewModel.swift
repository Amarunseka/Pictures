//
//  InitialPasswordViewModel.swift
//  Pictures
//
//  Created by Миша on 22.06.2022.
//

import UIKit

class InitialPasswordViewModel: LoginViewModelProtocol {
    
    // MARK: - initialise Elements
    var view = LoginView()
    var navigation = UIViewController()
    
    private var firstTryNewPassword: String?
    private lazy var loginIsValid = true
    private lazy var passwordIsValid = false
    private var loginIsExist = false
    
    // MARK: - Life cycle
    init(){
        checkExistencePassword()
        setupDelegates()
        
        view.actionButton.addTarget(self, action: #selector(targetButtonTapped), for: .touchUpInside)
        view.passwordTextField.becomeFirstResponder()
    }
    
    // MARK: - Private Methods
    private func checkExistencePassword(){
        guard let login = view.loginTextField.text else {return}
        let user = UserModel(username: login, password: "")
        
        if let _ = KeyChainManager.shared.retrievePassword(with: user) {
            loginIsExist = true
            view.actionButton.setTitle("Enter password", for: .normal)
        } else {
            view.actionButton.setTitle("Create new password", for: .normal)
        }
    }
    
    @objc
    private func targetButtonTapped(){
        passwordButtonTapped()
    }
    
    private func passwordButtonTapped(){
        if loginIsExist {
            loginExistButtonTapped()
        } else {
            createNewPasswordButtonTapped()
        }
    }
    
    private func loginExistButtonTapped(){
        guard let login = view.loginTextField.text,
              let password = view.passwordTextField.text else {return}
        
        let user = UserModel(username: login, password: password)
        
        if password == KeyChainManager.shared.retrievePassword(with: user) {
            segueToFilesVC()
        } else {
            navigation.showSimpleAlert(text: "Incorrect password or login")
        }
    }
    
    private func createNewPasswordButtonTapped(){
        guard let loginText = view.loginTextField.text,
              let passwordText = view.passwordTextField.text else {return}
        
        if firstTryNewPassword == nil {
            firstTryNewPassword = passwordText
            view.loginTextField.isEnabled = false
            view.loginTextField.alpha = 0.7
            view.passwordTextField.text = nil
            view.passwordTextField.placeholder = "Repeat password"
            view.actionButton.isValid = false
            view.actionButton.setTitle("Repeat password", for: .normal)
        } else {
            if firstTryNewPassword == view.passwordTextField.text {
                let user = UserModel(username: loginText, password: passwordText)
                KeyChainManager.shared.setPassword(with: user) ? segueToFilesVC() : print("error create password")
                resetPasswordField()
            } else {
                navigation.showSimpleAlert(text: "Passwords aren't the same")
                resetPasswordField()
            }
        }
    }
    
    private func resetPasswordField(){
        view.loginTextField.isEnabled = true
        view.loginTextField.alpha = 1
        firstTryNewPassword = nil
        view.passwordTextField.text = nil
        view.actionButton.isValid = false
        view.actionButton.setTitle("Create new password", for: .normal)
    }
    
    private func segueToFilesVC(){
        let vc = TabBarController()
        navigation.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - TextFields' delegate
extension InitialPasswordViewModel {
    
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
