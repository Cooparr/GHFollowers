//
//  GFRepoItemVC.swift
//  GHFollowers
//
//  Created by Alexander James Cooper on 01/12/2020.
//

import Foundation

protocol GFRepoItemVCDelegate: class {
    func didTapGitHubProfile(for user: User)
}

class GFRepoItemVC: GFItemInfoVC {
    
    //MARK: Properties
    weak var delegate: GFRepoItemVCDelegate!
    
    
    //MARK: Custom Init
    init(user: User, delegate: GFRepoItemVCDelegate) {
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
        itemInfoViewOne.set(itemInfoType: .repos, with: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, with: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "Github Profile")
    }
    
    
    //MARK: Action Button Tapped
    override func actionButtonTapped() {
        delegate.didTapGitHubProfile(for: user)
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
