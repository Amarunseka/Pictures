//
//  IsValidPasswordLabel.swift
//  Pictures
//
//  Created by Миша on 21.06.2022.
//

import UIKit

class IsValidPasswordLabel: UILabel {
    
    // MARK: - initialise Elements
    public var isValid = false {
        didSet {
            if isValid {
                passwordIsValid()
            } else {
                passwordIsNotValid()
            }
        }
    }
    
    // MARK: - life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - private methods-actions
    private func configure(){
        passwordIsNotValid()
        font = UIFont(name: "Apple SD Gothic Neo", size: 20)
        numberOfLines = 4
        adjustsFontSizeToFitWidth = true
    }
    
    private func passwordIsNotValid(){
        text = "Пароль должен содержать:\n  - большие и маленькие буквы латиницы\n  - цифры и спец. символы\n  - как минимум 6 знаков"
        textColor = #colorLiteral(red: 0.5215686275, green: 0.1098039216, blue: 0.05098039216, alpha: 1)
    }

    private func passwordIsValid(){
        text = nil
    }
}
