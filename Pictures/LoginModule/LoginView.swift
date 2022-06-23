//
//  LoginView.swift
//  Pictures
//
//  Created by Миша on 22.06.2022.
//

import UIKit

class LoginView: UIView {
    
    // MARK: - initialise Elements
    private let loginLabel = SpecialNameLabel(text: "Login")
    private let passwordLabel = SpecialNameLabel(text: "Password")
    let isValidPasswordLabel = IsValidPasswordLabel()
    let actionButton = LogInButton()
    
    let loginTextField: SpecialTexField = {
        let textField = SpecialTexField()
        textField.placeholder = "Enter login"
        textField.text = "Amarunseka"
        return textField
    }()
    
    let passwordTextField: SpecialTexField = {
        let textField = SpecialTexField()
        textField.placeholder = "Enter password"
        return textField
    }()
    
    // MARK: - Life cycle
    init(){
        super.init(frame: .zero)
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func setupView(){
        backgroundColor = .gray
        
        [loginLabel, passwordLabel, loginTextField, passwordTextField, actionButton, isValidPasswordLabel].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}


// MARK: - Constraints
extension LoginView {
    private func setConstraints(){
        let height = CGFloat(40)
        NSLayoutConstraint.activate([
            loginTextField.heightAnchor.constraint(equalToConstant: height),
            loginTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            loginTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            loginTextField.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -height * 3),
            
            loginLabel.bottomAnchor.constraint(equalTo: loginTextField.topAnchor, constant: -3),
            loginLabel.heightAnchor.constraint(equalToConstant: 20),
            loginLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            
            passwordLabel.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 15),
            passwordLabel.heightAnchor.constraint(equalToConstant: 20),
            passwordLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 3),
            passwordTextField.heightAnchor.constraint(equalToConstant: height),
            passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            actionButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 35),
            actionButton.heightAnchor.constraint(equalToConstant: height),
            actionButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            actionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            isValidPasswordLabel.topAnchor.constraint(equalTo: actionButton.bottomAnchor, constant: 15),
            isValidPasswordLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            isValidPasswordLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
        ])
    }
}
