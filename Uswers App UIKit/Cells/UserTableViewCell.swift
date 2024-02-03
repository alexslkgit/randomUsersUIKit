//
//  UserTableViewCell.swift
//  Users App UIKit
//
//  Created by Slobodianiuk Oleksandr on 26.01.2024.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!

    @IBOutlet weak var avatarImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layoutCell()
    }
    
    func layoutCell() {
        avatarImageView.layer.cornerRadius = 10
    }
    
    func configure(with user: UserUI) {
        
        self.userNameLabel.text = user.name
        self.locationLabel.text = user.location
        
        let largeImageURL = user.largeImageURL.asURL()
        let thumbnailURL = user.thumbnailURL.asURL()
        let personPlaceholderImage = UIImage(named: "person-thumbnail")
        
        avatarImageView.loadImage(largeImageURL,
                                  placeholderImage: personPlaceholderImage,
                                  smallImageUrl: thumbnailURL)

    }
    
}
