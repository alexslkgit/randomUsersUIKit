//
//  ViewController.swift
//  Uswers App UIKit
//

import UIKit

class UsersListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
        
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
    }
}

extension UsersListViewController: UITableViewDataSource {
    
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
}
