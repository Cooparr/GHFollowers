//
//  GFUserInfoHeaderVC.swift
//  GHFollowers
//
//  Created by Alexander James Cooper on 01/12/2020.
//

import UIKit

class GFUserInfoHeaderVC: UIViewController {

    //MARK: Properties
    var user: User!
    
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let usernameLabel = GFTitleLabel(textAlignment: .left, fontSize: 34)
    let nameLabel = GFSecondaryTitleLabel(fontSize: 18)
    let locationImageView = UIImageView()
    let locationLabel = GFSecondaryTitleLabel(fontSize: 18)
    let bioLabel = GFBodyLabel(textAlignment: .left)
    
    
    //MARK: Custom Init
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    
    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
        configureUIElements()
    }
    
    
    //MARK: Configure UI Elements
    fileprivate func configureUIElements() {
        usernameLabel.text = user.username
        nameLabel.text = user.name ?? "Not given"
        locationLabel.text = user.location ?? "Unknown"
        
        bioLabel.text = user.bio ?? "No bio given"
        bioLabel.numberOfLines = 3
        
        locationImageView.image = SFSymbols.location
        locationImageView.tintColor = .secondaryLabel
        downloadAvatarImage()
    }
    
    
    //MARK: Download Avatar Image
    fileprivate func downloadAvatarImage() {
        NetworkManager.shared.downloadImage(from: user.avatarURL) { [weak self] image in
            DispatchQueue.main.async { self?.avatarImageView.image = image }
        }
    }
    
    
    //MARK: Layout UI
    fileprivate func layoutUI() {
        let padding: CGFloat = 20
        let textImagePadding: CGFloat = 12
        
        view.addSubviews(avatarImageView, usernameLabel, nameLabel, locationImageView, locationLabel, bioLabel)
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            usernameLabel.heightAnchor.constraint(equalToConstant: 38),
            
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: usernameLabel.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            locationImageView.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            locationImageView.heightAnchor.constraint(equalTo: locationImageView.widthAnchor),
            
            locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
            locationLabel.trailingAnchor.constraint(equalTo: usernameLabel.trailingAnchor),
            locationLabel.heightAnchor.constraint(equalToConstant: 20),
            
            bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: textImagePadding),
            bioLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: usernameLabel.trailingAnchor),
            bioLabel.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
