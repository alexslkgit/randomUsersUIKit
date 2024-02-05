//
//  SettingsViewController.swift
//  Random Users UIKit
//

import UIKit

@MainActor
final class SettingsViewController: UIViewController {

    private let centralLabel = UIFactory.createLabel(text: Constants.Localizations.settingsScreen, alignment: .center)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        
        view.backgroundColor = .white
        view.addSubview(centralLabel)
        centralLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            centralLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centralLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
