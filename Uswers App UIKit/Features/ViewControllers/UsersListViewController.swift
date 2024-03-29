//
//  ViewController.swift
//  Uswers App UIKit
//

import UIKit

@MainActor
final class UsersListViewController: UIViewController {

    private lazy var tableView = UIFactory.createTableView(rowHeight: Constants.Layout.rowHeight,
                                                           dataSource: self,
                                                           delegate: self,
                                                           cellType: UserTableViewCell.self, 
                                                           accessID: Constants.AccessID.mainTableView)
    
    private lazy var refreshControl = UIFactory.createRefreshControl(target: self,
                                                                     action: #selector(refreshData(_:)))
    
    @Presenter var presenter: UsersListPresenter {
        didSet {
            loadViewIfNeeded()
            Task {
                await fetchUsers()
            }
        }
    }
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Private
    
    private func setupUI() {
        view.addSubview(tableView)
        view.backgroundColor = UIColor(named: Constants.Colors.backgroundMain)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        tableView.refreshControl = refreshControl
    }
    
    private func handleError(_ error: Error) {
        let alert = UIAlertController(title: Constants.Localizations.error,
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.Localizations.OK, style: .default))
        present(alert, animated: true)
    }
    
    @objc private func refreshData(_ sender: Any) {
        Task {
            await fetchUsers()
        }
    }
    
    private func fetchUsers() async {
        do {
            try await presenter.fetchUsers()
            await MainActor.run {
                tableView.reloadData()
                refreshControl.endRefreshing()
            }
        } catch {
            await MainActor.run {
                handleError(error)
                refreshControl.endRefreshing()
            }
        }
    }
    
}

extension UsersListViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Data Sourse
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return configureCell(tableView: tableView, indexPath: indexPath)
    }
    
    private func configureCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell: UserTableViewCell = tableView.dequeueReusableCell(for: UserTableViewCell.self, for: indexPath)
        let user = presenter.cellForRowAt(indexPath)
        cell.configure(with: user)
        return cell
    }
    
    // MARK: Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        Task { @MainActor in
            let userDetailsVC = UserDetailsViewController()
            let user = presenter.cellForRowAt(indexPath)
            userDetailsVC.presenter = UserDetailsPresenter(user: user)
            userDetailsVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(userDetailsVC, animated: true)
        }
    }
}
