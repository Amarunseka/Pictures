//
//  LoginViewController.swift
//  Pictures
//
//  Created by Миша on 21.06.2022.
//

import UIKit

class LoginViewController4: UIViewController {

    // MARK: - initialise Elements
    private var firstTryNewPassword: String?
    private lazy var loginIsValid = true
    private lazy var passwordIsValid = false

    
    private let loginLabel = SpecialNameLabel(text: "Login")
    private let passwordLabel = SpecialNameLabel(text: "Password")
    private let actionButton = LogInButton()
    private let isValidPasswordLabel = IsValidPasswordLabel()

    private let loginTextField: SpecialTexField = {
        let textField = SpecialTexField()
        textField.placeholder = "Enter login"
        textField.text = "Amarunseka"
        return textField
    }()
    
    private let passwordTextField: SpecialTexField = {
        let textField = SpecialTexField()
        textField.placeholder = "Enter password"
        return textField
    }()

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        checkExistencePassword()
        setupDelegates()

    }
    
    override func viewDidLayoutSubviews() {
        setConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        passwordTextField.becomeFirstResponder()
    }
    
    
    // MARK: - Methods
    private func setupView(){
        view.backgroundColor = .gray
        
        [loginLabel, passwordLabel, loginTextField, passwordTextField, actionButton, isValidPasswordLabel].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    
    private func checkExistencePassword(){
        guard let login = loginTextField.text else {return}
        let user = UserModel(username: login, password: "")

        if let _ = KeyChainManager.shared.retrievePassword(with: user) {
            actionButton.setTitle("Enter password", for: .normal)
            actionButton.addTarget(self, action: #selector(checkEnteredPasswordButtonTapped), for: .touchUpInside)
        } else {
            actionButton.setTitle("Create new password", for: .normal)
            actionButton.addTarget(self, action: #selector(createNewPasswordButtonTapped), for: .touchUpInside)
        }
    }
    
    @objc
    private func checkEnteredPasswordButtonTapped(){
        guard let login = loginTextField.text,
              let password = passwordTextField.text else {return}
        
        let user = UserModel(username: login, password: password)
        
        if password == KeyChainManager.shared.retrievePassword(with: user) {
            segueToFilesVC()
        } else {
            print("incorrect password")
        }
    }
    
    @objc
    private func createNewPasswordButtonTapped(){
        guard let login = loginTextField.text,
              let password = passwordTextField.text else {return}
        
        if firstTryNewPassword == nil {
            firstTryNewPassword = password
            loginTextField.isEnabled = false
            loginTextField.alpha = 0.7
            passwordTextField.text = nil
            passwordTextField.placeholder = "Repeat password"
            actionButton.isValid = false
            actionButton.setTitle("Repeat password", for: .normal)
        } else {
            if firstTryNewPassword == password {
                let user = UserModel(username: login, password: password)
                KeyChainManager.shared.setPassword(with: user) ? segueToFilesVC() : print("error create password")
                resetPasswordField()
            } else {
                print("Passwords are not the same")
                resetPasswordField()
            }
        }
    }
    
    private func resetPasswordField(){
        loginTextField.isEnabled = true
        loginTextField.alpha = 1
        firstTryNewPassword = nil
        passwordTextField.text = nil
        actionButton.isValid = false
        actionButton.setTitle("Create new password", for: .normal)
    }
    
    private func segueToFilesVC(){
        let vc = TabBarController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - TextFields' delegate
extension LoginViewController4 {
    
    func setupDelegates(){
        loginTextField.textFieldDelegate = { [weak self] text in
            guard let self = self else {return}
            self.loginIsValid = text.loginIsValid()
            self.actionButton.isValid = self.loginIsValid && self.passwordIsValid
        }

        passwordTextField.textFieldDelegate = { [weak self] text in
            guard let self = self else {return}
            self.passwordIsValid = text.passwordIsValid()
            self.actionButton.isValid = self.loginIsValid && self.passwordIsValid
            self.isValidPasswordLabel.isValid = self.passwordIsValid
        }


        loginTextField.textFieldClearAction = { [weak self] in
            guard let self = self else {return}
            self.loginIsValid = false
            self.actionButton.isValid = self.loginIsValid && self.passwordIsValid
        }

        passwordTextField.textFieldClearAction = { [weak self] in
            guard let self = self else {return}
            self.passwordIsValid = false
            self.actionButton.isValid = self.loginIsValid && self.passwordIsValid
            self.isValidPasswordLabel.isValid = self.passwordIsValid
        }
    }
}

// MARK: - Constraints
extension LoginViewController4 {
    private func setConstraints(){
        let height = CGFloat(40)
        NSLayoutConstraint.activate([
            loginTextField.heightAnchor.constraint(equalToConstant: height),
            loginTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            loginTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            loginTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -height * 3),
            
            loginLabel.bottomAnchor.constraint(equalTo: loginTextField.topAnchor, constant: -3),
            loginLabel.heightAnchor.constraint(equalToConstant: 20),
            loginLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            
            passwordLabel.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 15),
            passwordLabel.heightAnchor.constraint(equalToConstant: 20),
            passwordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 3),
            passwordTextField.heightAnchor.constraint(equalToConstant: height),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),

            actionButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 35),
            actionButton.heightAnchor.constraint(equalToConstant: height),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),

            isValidPasswordLabel.topAnchor.constraint(equalTo: actionButton.bottomAnchor, constant: 15),
            isValidPasswordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            isValidPasswordLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
        ])
    }
}


