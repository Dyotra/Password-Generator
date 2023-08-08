//
//  ViewModel.swift
//  PasswordGenerator
//
//  Created by Bekpayev Dias on 07.08.2023.
//

import Foundation
import UIKit

class Observable<T> {
    var value: T {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.listener?(self!.value)
            }
        }
    }
    
    private var listener: ((T) -> Void)?
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(listener: @escaping (T) -> Void) {
        self.listener = listener
        listener(value)
    }
}

class ViewModel {
    
    var generatedPassword: Observable<String> = Observable("")
    var savedPasswords: [String] = []
    
    func generatePassword() -> String {
        let length = 12
        let allowedCharacters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let newPassword = String((0..<length).map { _ in allowedCharacters.randomElement()! })
        return newPassword
    }
    
    func savePassword() {
        let newPassword = generatePassword() 
        if !newPassword.isEmpty {
            savedPasswords.append(newPassword)
        } else {
            fatalError("Generated password is empty")
        }
    }
}
