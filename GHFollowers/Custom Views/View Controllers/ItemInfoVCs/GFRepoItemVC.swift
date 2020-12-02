//
//  GFRepoItemVC.swift
//  GHFollowers
//
//  Created by Alexander James Cooper on 01/12/2020.
//

import Foundation

class GFRepoItemVC: GFItemInfoVC {
    
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
}
