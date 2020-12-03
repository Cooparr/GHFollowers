//
//  GFFavoriteCell.swift
//  GHFollowers
//
//  Created by Alexander James Cooper on 02/12/2020.
//

import UIKit

class GFFavoriteCell: UITableViewCell {

    //MARK: Properties
    static let reuseId = "FavoriteCellId"
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let usernameLabel = GFTitleLabel(textAlignment: .left, fontSize: 26)
    
    
    //MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    
    // Set Cell Content
    func set(favorite: Follower) {
        usernameLabel.text = favorite.username
        avatarImageView.downloadImage(fromURL: favorite.avatarURL)
    }
    
    
    //MARK: Configure
    private func configure() {
        accessoryType = .disclosureIndicator

        let padding: CGFloat = 12
        addSubviews(avatarImageView, usernameLabel)
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            usernameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: padding * 2),
            usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
