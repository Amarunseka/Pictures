//
//  InitialPasswordViewModel.swift
//  Pictures
//
//  Created by Миша on 22.06.2022.
//

import UIKit

class InitialPasswordViewModel: PasswordViewModel {
    
    // MARK: - initialise Elements
    private var loginIsExist = false
    
    // MARK: - Life cycle
    override init(){
        super.init()
        checkExistencePassword()
    }
    
    // MARK: - Private Methods
    private func checkExistencePassword(){
        guard let login = view.loginTextField.text else {return}
        let user = UserModel(username: login, password: "")
        
        if KeyChainManager.shared.retrievePassword(with: user) != nil {
            loginIsExist = true
            setAttributes(text: "Enter password")
        } else {
            setAttributes(text: "Create new password")
        }
    }
    
    @objc
    override func targetButtonTapped(){
        if loginIsExist {
            checkThePassword()
        } else {
            createNewPassword()
        }
    }
    
    private func checkThePassword(){
        guard let login = view.loginTextField.text,
              let password = view.passwordTextField.text else {return}
        
        let user = UserModel(username: login, password: password)
        
        if password == KeyChainManager.shared.retrievePassword(with: user) {
            segueToFilesVC()
        } else {
            navigation.showSimpleAlert(text: "Incorrect password or login")
        }
        resetPasswordField()
    }
    
    private func createNewPassword(){
        guard let loginText = view.loginTextField.text,
              let passwordText = view.passwordTextField.text else {return}
        
        if firstTryNewPassword == nil {
            firstStepCreatingPassword(password: passwordText)
        } else {
            secondStepCreatingPassword(login: loginText, password: passwordText)
            resetPasswordField()
        }
    }
    
    private func firstStepCreatingPassword(password: String){
            firstTryNewPassword = password
            view.loginTextField.isEnabled = false
            view.loginTextField.alpha = 0.7
            view.passwordTextField.text = nil
            view.actionButton.isValid = false
            view.isValidPasswordLabel.resetConfigure()
            setAttributes(text: "Repeat password")
    }

    private func secondStepCreatingPassword(login: String, password: String){
        if firstTryNewPassword == password {
            let user = UserModel(username: login, password: password)
            switch KeyChainManager.shared.setPassword(with: user) {
            case true:
                segueToFilesVC()
            case false:
                setAttributes(text: "Create new password")
                navigation.showSimpleAlert(text: "Password isn't created")
            }
        } else {
            setAttributes(text: "Create new password")
            navigation.showSimpleAlert(text: "Passwords aren't the same")
        }
    }
    
    private func setAttributes(text: String) {
        view.passwordTextField.placeholder = text
        view.actionButton.setTitle(text, for: .normal)
    }
    
    private func resetPasswordField(){
        firstTryNewPassword = nil
        view.loginTextField.isEnabled = true
        view.loginTextField.alpha = 1
        view.passwordTextField.text = nil
        view.actionButton.isValid = false
        view.isValidPasswordLabel.resetConfigure()
    }
    
    private func segueToFilesVC(){
        let vc = TabBarController()
        navigation.navigationController?.pushViewController(vc, animated: true)
    }
}
