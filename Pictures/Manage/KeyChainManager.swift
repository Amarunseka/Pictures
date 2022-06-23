//
//  KeyChainManager.swift
//  Pictures
//
//  Created by Миша on 21.06.2022.
//

import Foundation

class KeyChainManager {
    
    static let shared = KeyChainManager()
    private init(){}
    
    func setPassword(with user: UserModel) -> Bool{
        // Переводим пароль в объект класс Data
        guard let passData = user.password.data(using: .utf8) else {
            print("Невозможно получить Data из пароля")
            return false
        }
        
        // Создаем атрибуты для хранения файла
        let attributes = [
            kSecClass: kSecClassGenericPassword,
            kSecValueData: passData,
            kSecAttrAccount: user.username,
            kSecAttrService: user.serviceName,
        ] as CFDictionary
        
        // Добавляем новую запись в Keychain
        let status = SecItemAdd(attributes, nil)
        
        guard status == errSecDuplicateItem || status == errSecSuccess else {
            print("Невозможно добавить пароль, ошибка номер: \(status)")
            return false
        }
        
        print("Новый пароль добавлен успешно")
        return true
    }
    
    func retrievePassword(with user: UserModel) -> String? {
        // Создаем поисковые атрибуты
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: user.serviceName,
            kSecAttrAccount: user.username,
            kSecReturnData: true
        ] as CFDictionary
        
        // Объявляем ссылку на объект, которая в будущем будет указывать на полученную запись Keychain
        var extractedData: AnyObject?
        // Запрашиваем запись в keychain
        let status = SecItemCopyMatching(query, &extractedData)
        
        guard status == errSecItemNotFound || status == errSecSuccess else {
            print("Невозможно получить пароль, ошибка номер: \(status)")
            return nil
        }
        
        guard status != errSecItemNotFound else {
            print("Пароль не найден в Keychain")
            return nil
        }
        
        guard let passData = extractedData as? Data,
              let password = String(data: passData, encoding: .utf8) else {
                  print("невозможно преобразовать data в пароль")
                  return nil
              }
        
        return password
    }
    
    func updatePassword(with user: UserModel) -> Bool{
        // Переводим пароль в объект класс Data
        guard let passData = user.password.data(using: .utf8) else {
            print("Невозможно получить Data из пароля")
            return false
        }
        
        // Создаем поисковые атрибуты
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: user.serviceName,
            kSecAttrAccount: user.username,
            kSecReturnData: false // не обязательно, false по- умолчанию
        ] as CFDictionary
        
        let attributesToUpdate = [
            kSecValueData: passData,
        ] as CFDictionary
        
        let status = SecItemUpdate(query, attributesToUpdate)
        
        guard status == errSecSuccess else {
            print("Невозможно обновить пароль, ошибка номер: \(status)")
            return false
        }
        
        print("Новый пароль обновлен успешно")
        return true
    }
    
    func deletePassword(with user: UserModel) -> Bool{
        // Создаем поисковые атрибуты
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: user.serviceName,
            kSecAttrAccount: user.username,
            kSecReturnData: false  // не обязательно, false по- умолчанию
        ] as CFDictionary
        
        let status = SecItemDelete(query)
        
        guard status == errSecSuccess || status == errSecItemNotFound else {
            print("Невозможно удалить пароль, ошибка номер: \(status)")
            return false
        }
        
        print("Новый пароль удален успешно")
        return true
    }
}
