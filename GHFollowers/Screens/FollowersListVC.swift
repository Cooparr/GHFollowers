//
//  FollowersListVC.swift
//  GHFollowers
//
//  Created by Alexander James Cooper on 27/11/2020.
//

import UIKit

class FollowersListVC: UIViewController {

    //MARK: Properties
    var username: String!
    
    
    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        NetworkManager.shared.getFollowers(for: username, page: 1) { followers, errorMessasge in
            guard let followers = followers else {
                self.presentGFAlertOnMainThread(title: "Bad Stuff Happened", message: errorMessasge!.rawValue, buttonTitle: "Ok")
                return
            }
            
            print("Followers Count: ", followers.count)
            print(followers)
        }
    }
    
    
    //MARK: View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
