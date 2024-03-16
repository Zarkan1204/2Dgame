//
//  ScoreViewController.swift
//  2Dgame
//
//  Created by Мой Macbook on 13.02.2024.
//

import SnapKit
import UIKit

final class ScoreViewController: UIViewController {
    
    private var users: [User] = []
    
    //MARK: - Properties
    
    private lazy var scoreTableView: UITableView = {
        let tableView = UITableView()
        tableView.estimatedRowHeight = .rowHeight
        tableView.register(ScoreTableViewCell.self, forCellReuseIdentifier: ScoreTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        users = StorageManager.shared.users
        setupViews()
        setupLayout()
        scoreTableView.reloadData()
    }
    
    //MARK: - Functions
    
    private func setupViews() {
        title = Constants.title
        view.backgroundColor = .white
        view.addSubview(scoreTableView)
    }
    
    private func setupLayout() {

        scoreTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate

extension ScoreViewController:  UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ScoreTableViewCell.identifier, for: indexPath) as? ScoreTableViewCell else { return UITableViewCell()
        }
        cell.configure(with: users[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            _ = users.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            StorageManager.shared.users = users
            StorageManager.shared.saveUsersData()
            tableView.reloadData()
        }
    }
}

//MARK: - Constants

private enum Constants {
    static let title = "Results table"
}
