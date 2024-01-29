//
//  ViewController.swift
//  Uswers App UIKit
//

import UIKit

class UsersListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let refreshControl = UIRefreshControl()
    
    var viewModel: UsersListViewModel! {
        didSet {
            loadViewIfNeeded()
            viewModel.fetchUsers {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        viewModel.fetchUsers {
            self.tableView.reloadData()
        }
    }
    
    private func setupUI() {
        
        tableView.register(cell: UserTableViewCell.self)
        tableView.rowHeight = 120
        
        refreshControl.addTarget(self,
                                 action: #selector(refreshData(_:)),
                                 for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc private func refreshData(_ sender: Any) {
        viewModel.fetchUsers {
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
}


extension UsersListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, 
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(for: UserTableViewCell.self,
                                                 for: indexPath)
        let user = self.viewModel.cellForRowAt(indexPath)
        cell.configure(with: user)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let userDetailsViewController = storyboard.instantiateViewController(ofType: UserDetailsViewController.self) {
            let user = viewModel.cellForRowAt(indexPath)
            let userDetailsViewModel = UserDetailsViewModel(user: user)
            userDetailsViewController.viewModel = userDetailsViewModel

            navigationController?.pushViewController(userDetailsViewController, animated: true)
        }
    }

}
