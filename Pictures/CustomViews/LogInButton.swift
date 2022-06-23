//
//  LogInButton.swift
//  Pictures
//
//  Created by Миша on 21.06.2022.
//

import UIKit

class LogInButton: UIButton {

    // MARK: - initialise Elements
    var isValid = false {
        didSet {
            if isValid {
                passwordIsValid()
            } else {
                passwordIsNotValid()
            }
        }
    }

    // MARK: - life cycle
    convenience init() {
        self.init(type: .system)
        configure()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - private methods-actions
    private func configure() {
        backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.9333333333, blue: 0.862745098, alpha: 1)
        let color  = #colorLiteral(red: 0.2156862745, green: 0.2156862745, blue: 0.2156862745, alpha: 1)
        setTitleColor(color, for: .normal)
        layer.cornerRadius = 10
        titleLabel?.font = UIFont(name: "Avenir Book", size: 17)
        isEnabled = false
        alpha = 0.5
    }
    
    private func passwordIsNotValid(){
        isEnabled = false
        alpha = 0.5
    }
    
    private func passwordIsValid(){
        isEnabled = true
        alpha = 1
    }
}
