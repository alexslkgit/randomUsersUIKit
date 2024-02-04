//
//  UserDetailsViewController.swift
//  Random Users UIKit
//

import UIKit

class UserDetailsViewController: UIViewController {
   
    private let avatarImageView = UIFactory.createImageView(accessID: Constants.AccessID.avatarImageView)
    private let nameLabel = UIFactory.createLabel(accessID: Constants.AccessID.nameLabel)
    private let locationLabel = UIFactory.createLabel(accessID: Constants.AccessID.locationLabel)
    private let backItem = UIFactory.createBackItem(title: Constants.Localizations.backToList, 
                                                    accessID: Constants.AccessID.backBarButtonItem)
    
    var viewModel: UserDetailsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupTapGesture()
    }
    
    // MARK: - Private

    private func setupUI() {
        
        view.backgroundColor = .white
        view.addSubview(avatarImageView)
        view.addSubview(nameLabel)
        view.addSubview(locationLabel)
 
        navigationController?.navigationBar.topItem?.backBarButtonItem = backItem
        
        nameLabel.text = viewModel.user.name
        locationLabel.text = viewModel.user.location
        avatarImageView.loadImage(viewModel.user.mediumImageURL,
                                  placeholderImage: UIImage(named: Constants.Images.userLogo),
                                  smallImageUrl: viewModel.user.thumbnailURL)
        
        let spacing = Constants.Layout.defaultSpacing
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            avatarImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            avatarImageView.heightAnchor.constraint(equalTo: view.widthAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: spacing),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: spacing),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -spacing),
            
            locationLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: spacing/2),
            locationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: spacing),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -spacing)
        ])
    }
    
    private func setupTapGesture() {
        
        let action = #selector(imageTapped(tapGestureRecognizer:))
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: action)
        avatarImageView.isUserInteractionEnabled = true
        avatarImageView.addGestureRecognizer(tapGestureRecognizer)
    }

    @objc private func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        avatarImageView.loadImage(viewModel.user.largeImageURL)
    }
}
