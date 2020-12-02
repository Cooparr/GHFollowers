//
//  GFFollowerItemVC.swift
//  GHFollowers
//
//  Created by Alexander James Cooper on 02/12/2020.
//

import Foundation

class GFFollowerItemVC: GFItemInfoVC {
    
    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    
    //MARK: Configure Items
    fileprivate func configureItems() {
        itemInfoViewOne.set(itemInfoType: .followers, with: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, with: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
    
    
    //MARK: Action Button Tapped
    override func actionButtonTapped() {
        delegate.didTapGetFollowers(for: user)
    }
}
