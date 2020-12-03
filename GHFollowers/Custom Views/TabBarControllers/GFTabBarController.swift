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
            createNC(vc: SearchVC(), title: "Search", icon: SFSymbols.search),
            createNC(vc: FavouritesListVC(), title: "Favorites", icon: SFSymbols.favorites)
        ]
    }

    
    //MARK: Create Nav Controller
    private func createNC(vc: UIViewController, title: String, icon: UIImage?) -> UINavigationController {
        vc.title = title
        vc.tabBarItem.image = icon
        return UINavigationController(rootViewController: vc)
    }
}
