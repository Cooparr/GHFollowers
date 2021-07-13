//
//  GFFollowerItemVC.swift
//  GHFollowers
//
//  Created by Alexander James Cooper on 02/12/2020.
//

import Foundation

protocol GFFollowerItemVCDelegate: AnyObject {
    func didTapGetFollowers(for user: User)
}

class GFFollowerItemVC: GFItemInfoVC {
    
    //MARK: Properties
    weak var delegate: GFFollowerItemVCDelegate!
    
    
    //MARK: Custom Init
    init(user: User, delegate: GFFollowerItemVCDelegate) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    
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
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
