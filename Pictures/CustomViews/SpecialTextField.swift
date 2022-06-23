//
//  SpecialTextField.swift
//  Pictures
//
//  Created by Миша on 21.06.2022.
//

import UIKit

class SpecialTexField: UITextField {
    
    // MARK: - initialise Elements
    var textFieldDelegate: ((String)->())?
    var textFieldClearAction: (()->())?
    var textFieldShouldReturnAction: (()->())?

    // MARK: - life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - private Methods
    private func configure() {
        delegate = self
        backgroundColor = .white
        borderStyle = .none
        layer.cornerRadius = 10
        textColor = #colorLiteral(red: 0.2156862745, green: 0.2156862745, blue: 0.2156862745, alpha: 1)
        leftView = UIView(frame: CGRect(
            x: 0,
            y: 0,
            width: 15,
            height: self.frame.height))
        leftViewMode = .always
        clearButtonMode = .always
        returnKeyType = .done
        font = UIFont(name: "Apple SD Gothic Neo", size: 20)
        tintColor = #colorLiteral(red: 0.5019607843, green: 0.5019607843, blue: 0.5019607843, alpha: 1)
    }
}

// MARK: - Setup TextField
extension SpecialTexField: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.resignFirstResponder()
        guard let action = textFieldShouldReturnAction else {return true}
        action()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if let text = textField.text,
           let rangeText = Range(range, in: text) {
            let updateText = text.replacingCharacters(in: rangeText, with: string)
            guard let delegate = textFieldDelegate else {return false}
            delegate(updateText)
        }
        return true
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {

        guard let textFieldClearAction = textFieldClearAction else {return false}
        textFieldClearAction()
        return true
    }
}
