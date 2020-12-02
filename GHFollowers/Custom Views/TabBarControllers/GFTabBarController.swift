//
//  GFTabBarController.swift
//  GHFollowers
//
//  Created by Alexander James Cooper on 02/12/2020.
//

import UIKit

class GFTabBarController: UITabBarController {

    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemGreen
        viewControllers = [
            createNC(vc: SearchVC(), title: "Search", iconName: "magnifyingglass"),
            createNC(vc: FavouritesListVC(), title: "Favorites", iconName: "star.fill")
        ]
    }

    
    //MARK: Create Nav Controller
    private func createNC(vc: UIViewController, title: String, iconName: String) -> UINavigationController {
        vc.title = title
        vc.tabBarItem.image = UIImage(systemName: iconName)
        return UINavigationController(rootViewController: vc)
    }
}
