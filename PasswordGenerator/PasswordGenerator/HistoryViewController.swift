//
//  HistoryViewController.swift
//  PasswordGenerator
//
//  Created by Bekpayev Dias on 08.08.2023.
//
import UIKit
import Foundation

class PasswordHistoryViewController: UIViewController {
    var viewModel = ViewModel()
    
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScene()
    }
    
    private func setupScene() {
        view.backgroundColor = .white
        title = "Password History"
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension PasswordHistoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = viewModel.savedPasswords.count
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let password = viewModel.savedPasswords[indexPath.row]
        cell.textLabel?.text = password
        return cell
    }
}
