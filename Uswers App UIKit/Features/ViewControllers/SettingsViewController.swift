//
//  SettingsViewController.swift
//  Random Users UIKit
//

import UIKit

class SettingsViewController: UIViewController {

    private let centralLabel = UIFactory.createLabel(text: Constants.Localizations.settingsScreen, alignment: .center)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(centralLabel)
        
        NSLayoutConstraint.activate([
            centralLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centralLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
