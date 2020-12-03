//
//  FavouritesListVC.swift
//  GHFollowers
//
//  Created by Alexander James Cooper on 26/11/2020.
//

import UIKit

class FavouritesListVC: GFDataLoadingVC {

    //MARK: Properties
    let tableView = UITableView()
    var favorites = [Follower]()
    
    
    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureVC()
        configureTableView()
    }
    
    
    //MARK: View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }
    
    
    //MARK: Configure VC
    fileprivate func configureVC() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Favorites"
    }
    
    
    //MARK: Configure VC
    fileprivate func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(GFFavoriteCell.self, forCellReuseIdentifier: GFFavoriteCell.reuseId)
    }
    
    
    //MARK: Get Favorites
    func getFavorites() {
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let favorites):
                if favorites.isEmpty {
                    self.showEmptyStateView(with: "No favorites to show!\nAdd one on the follower scren.", in: self.view)
                } else {
                    self.favorites = favorites
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                    }
                }
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
}


extension FavouritesListVC: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Height For Row At
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    //MARK: Number Of Rows In Section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    
    //MARK: Cell For Row At
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GFFavoriteCell.reuseId, for: indexPath) as! GFFavoriteCell
        cell.set(favorite: favorites[indexPath.row])
        return cell
    }
    
    
    //MARK: Did Select Row At
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favorites[indexPath.row]
        let destionationVC = FollowersListVC(username: favorite.username)
        navigationController?.pushViewController(destionationVC, animated: true)
    }
    
    
    //MARK: Commit Editing Style
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let favorite = favorites[indexPath.row]
        favorites.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        
        PersistenceManager.updateWith(favorite: favorite, actionType: .remove) { [weak self] error in
            guard let self = self else { return }
            guard let error = error else { return }
            self.presentGFAlertOnMainThread(title: "Error Deleting", message: error.rawValue, buttonTitle: "Ok")
        }
    }
}
