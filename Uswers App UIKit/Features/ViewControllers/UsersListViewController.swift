//
//  ViewController.swift
//  Uswers App UIKit
//

import UIKit

@MainActor
class UsersListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        return control
    }()
    
    var viewModel: UsersListViewModel! {
        didSet {
            loadViewIfNeeded()
            self.fetchUsers()
        }
    }
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: Data Sourse
    
    private func setupUI() {
        tableView.register(cell: UserTableViewCell.self)
        tableView.rowHeight = Constants.Size.rowHeight
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
        self.fetchUsers()
    }
    
    private func fetchUsers () {
        viewModel.fetchUsers { [weak self] result in
            Task { @MainActor in
                switch result {
                case .success():
                    self?.tableView.reloadData()
                case .failure(let error):
                    self?.handleError(error)
                }
            }
        }
    }
    
}

extension UsersListViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Data Sourse
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return configureCell(tableView: tableView, indexPath: indexPath)
    }
    
    private func configureCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell: UserTableViewCell = tableView.dequeueReusableCell(for: UserTableViewCell.self, for: indexPath)
        let user = viewModel.cellForRowAt(indexPath)
        cell.configure(with: user)
        return cell
    }
    
    // MARK: Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        Task { @MainActor in
            let storyboard = UIStoryboard(name: Constants.Storyboard.main, bundle: nil)
            guard let userDetailsVC = storyboard.instantiateViewController(ofType: UserDetailsViewController.self) else { return }
            let user = viewModel.cellForRowAt(indexPath)
            userDetailsVC.viewModel = UserDetailsViewModel(user: user)
            userDetailsVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(userDetailsVC, animated: true)
        }
    }
}
