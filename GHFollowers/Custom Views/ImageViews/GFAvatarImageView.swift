//
//  GFAvatarImageView.swift
//  GHFollowers
//
//  Created by Alexander James Cooper on 30/11/2020.
//

import UIKit

class GFAvatarImageView: UIImageView {

    //MARK: Properties
    let cache = NetworkManager.shared.cache
    let placeholderImage = Images.avatarPlaceholder
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    //MARK: Configure
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
