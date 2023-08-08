//
//  ViewController.swift
//  PasswordGenerator
//
//  Created by Bekpayev Dias on 07.08.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private let viewModel = ViewModel()
    
    private let passwordLabel: UITextField = {
        let textField = UITextField()
           textField.placeholder = "Generated Password"
           textField.textAlignment = .center
           textField.font = UIFont.systemFont(ofSize: 18)
           return textField
    }()
    
    
    private let generateButton: UIButton = {
        let button = UIButton()
        button.setTitle("Generate Password", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save Password", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    private let passwordHistoryButton: UIButton = {
        let button = UIButton()
        button.setTitle("Password History", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setupScene()
        makeConstraints()
    }
    
    
    
    private func bindViewModel() {
        viewModel.generatedPassword.bind { [weak self] newPassword in
            self?.passwordLabel.text = newPassword
        }
    }
    
    @objc private func generateButtonTapped() {
        let newPassword = viewModel.generatePassword()
        passwordLabel.text = newPassword
    }
    
    @objc private func saveButtonTapped() {
        viewModel.savePassword()
        passwordLabel.text = "Password Saved!"
    }
    
    @objc private func passwordHistoryButtonTapped() {
        let historyVC = PasswordHistoryViewController()
            navigationController?.pushViewController(historyVC, animated: true)
    }
}

extension ViewController {
    func makeConstraints() {
        passwordLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-100)
        }
        
        generateButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordLabel.snp.bottom).offset(20)
        }
        
        saveButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(generateButton.snp.bottom).offset(20)
        }
        
        passwordHistoryButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(saveButton.snp.bottom).offset(20)
        }
    }
    
    func setupScene() {
        view.addSubview(passwordLabel)
        view.addSubview(generateButton)
        view.addSubview(saveButton)
        view.addSubview(passwordHistoryButton)
        generateButton.addTarget(self, action: #selector(generateButtonTapped), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        passwordHistoryButton.addTarget(self, action: #selector(passwordHistoryButtonTapped), for: .touchUpInside)
    }
}


