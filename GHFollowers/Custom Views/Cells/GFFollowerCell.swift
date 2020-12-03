//
//  GFFollowerCell.swift
//  GHFollowers
//
//  Created by Alexander James Cooper on 30/11/2020.
//

import UIKit

class GFFollowerCell: UICollectionViewCell {
    
    //MARK: Properties
    static let reuseId = "FollowerCellId"
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let usernameLabel = GFTitleLabel(textAlignment: .center, fontSize: 16)
    
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }
    
    
    // Set Cell Content
    func set(follower: Follower) {
        usernameLabel.text = follower.username
        NetworkManager.shared.downloadImage(from: follower.avatarURL) { [weak self] image in
            DispatchQueue.main.async { self?.avatarImageView.image = image }
        }
    }
    
    
    //MARK: Configure
    private func configure() {
        let padding: CGFloat = 8
        addSubviews(avatarImageView, usernameLabel)
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            usernameLabel.trailingAnchor.constraint(equalTo: avatarImageView.trailingAnchor),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
