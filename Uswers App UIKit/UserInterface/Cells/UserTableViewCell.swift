//
//  UserTableViewCell.swift
//  Users App UIKit
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!

    @IBOutlet weak var avatarImageView: UIImageView!
    
    // MARK: - Life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        avatarImageView.layer.cornerRadius = 10
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.tag = 0
        avatarImageView.image = nil
    }
    
    func configure(with user: UserUI) {
        
        self.userNameLabel.text = user.name
        self.locationLabel.text = user.location
        
        let largeImageURL = user.largeImageURL.asURL()
        let thumbnailURL = user.thumbnailURL.asURL()
        let personPlaceholderImage = UIImage(named: Constants.Images.userLogo)
        
        avatarImageView.loadImage(largeImageURL,
                                  placeholderImage: personPlaceholderImage,
                                  smallImageUrl: thumbnailURL)
    }
}
