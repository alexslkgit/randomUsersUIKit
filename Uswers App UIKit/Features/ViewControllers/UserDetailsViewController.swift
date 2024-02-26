//
//  UserDetailsViewController.swift
//  Random Users UIKit
//

import UIKit

@MainActor
final class UserDetailsViewController: UIViewController {
    
    private let avatarImageView = UIFactory.createImageView(accessID: Constants.AccessID.avatarImageView)
    private let nameLabel = UIFactory.createLabel(accessID: Constants.AccessID.nameLabel)
    private let locationLabel = UIFactory.createLabel(accessID: Constants.AccessID.locationLabel)
    private let backItem = UIFactory.createBackItem(title: Constants.Localizations.backToList,
                                                    accessID: Constants.AccessID.backBarButtonItem)
    
    @ViewModel var viewModel: UserDetailsViewModel

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupTapGesture()
    }
    
    // MARK: - Private

    private func setupUI() {
        
        view.backgroundColor = UIColor(named: Constants.Colors.backgroundMain)
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
        let avatarWidth = view.frame.width / 2

        NSLayoutConstraint.activate([
            
            avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.Layout.defaultSpacing),
            avatarImageView.widthAnchor.constraint(equalToConstant: avatarWidth),
            avatarImageView.heightAnchor.constraint(equalToConstant: avatarWidth),
            
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
        
        let fullScreenVC = FullScreenImageViewController()
        fullScreenVC.viewModel = FullScreenImageViewModel(imageURL: viewModel.user.largeImageURL)
        fullScreenVC.modalPresentationStyle = .fullScreen
        present(fullScreenVC, animated: true)
    }
}
