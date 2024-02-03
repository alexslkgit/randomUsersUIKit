//
//  UserDetailsViewController.swift
//  Random Users UIKit
//

import UIKit

class UserDetailsViewController: UIViewController {
   
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    var viewModel: UserDetailsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupTapGesture()
    }

    private func setupUI() {
        nameLabel.text = viewModel.user.name
        locationLabel.text = viewModel.user.location
        avatarImageView.loadImage(viewModel.user.mediumImageURL,
                                  placeholderImage: UIImage(named: Constants.Images.userLogo),
                                  smallImageUrl: viewModel.user.thumbnailURL)
    }
    
    private func setupTapGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        avatarImageView.isUserInteractionEnabled = true
        avatarImageView.addGestureRecognizer(tapGestureRecognizer)
    }

    @objc private func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        avatarImageView.loadImage(viewModel.user.largeImageURL)
    }
}
