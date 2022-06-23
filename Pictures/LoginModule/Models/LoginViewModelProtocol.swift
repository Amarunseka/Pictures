//
//  LoginViewModelProtocol.swift
//  Pictures
//
//  Created by Миша on 23.06.2022.
//

import UIKit

protocol LoginViewModelProtocol {
    var view: LoginView { get }
    var navigation: UIViewController { get set }
}
