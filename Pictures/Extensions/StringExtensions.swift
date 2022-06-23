//
//  StringExtensions.swift
//  Pictures
//
//  Created by Миша on 21.06.2022.
//

import Foundation

extension String {
    
    func passwordIsValid() -> Bool{
        
        let format = "SELF MATCHES %@"
        let regEx = "(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[!@#$%^&*()§±><№:,.;`~?/|'])[^а-яА-Я]{6,}"
        return NSPredicate(format: format, regEx).evaluate(with: self)
    }
    
    func loginIsValid() -> Bool{
        let format = "SELF MATCHES %@"
        let regEx = "[^а-яА-Я ]{2,}"
        return NSPredicate(format: format, regEx).evaluate(with: self)
    }
}
