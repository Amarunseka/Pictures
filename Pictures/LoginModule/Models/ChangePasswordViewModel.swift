//
//  ChangePasswordViewModel.swift
//  Pictures
//
//  Created by Миша on 23.06.2022.
//

import UIKit

class ChangePasswordViewModel: PasswordViewModel {
    // MARK: - Methods
    override init(){
        super.init()
        setupViews()
    }
    
    // MARK: - Private Methods
    private func setupViews(){
        view.loginTextField.isEnabled = false
        view.loginTextField.alpha = 0.7
        setAttributes(text: "Create new password")
    }
    
    @objc
    override func targetButtonTapped(){
        guard let loginText = view.loginTextField.text,
              let passwordText = view.passwordTextField.text else {return}
        
        if firstTryNewPassword == nil {
            firstStepCreatingPassword(password: passwordText)
        } else {
            secondStepCreatingPassword(login: loginText, password: passwordText)
        }
        resetPasswordField()
    }
    
    private func firstStepCreatingPassword(password: String){
            firstTryNewPassword = password
            setAttributes(text: "Repeat password")
    }

    private func secondStepCreatingPassword(login: String, password: String){
        if firstTryNewPassword == password {
            let user = UserModel(username: login, password: password)
            
            switch  KeyChainManager.shared.updatePassword(with: user) {
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
        firstTryNewPassword = nil
    }
    
    private func setAttributes(text: String) {
        view.passwordTextField.placeholder = text
        view.actionButton.setTitle(text, for: .normal)
    }
    
    
    private func resetPasswordField(){
        view.passwordTextField.text = nil
        view.actionButton.isValid = false
        view.isValidPasswordLabel.resetConfigure()
    }
    
    private func segueToFilesVC(){
            self.navigation.SuccessChangePasswordAlert(text: "Password is changed") {
                self.navigation.dismiss(animated: true)
        }
    }
}
