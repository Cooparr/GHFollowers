//
//  FollowersListVC.swift
//  GHFollowers
//
//  Created by Alexander James Cooper on 27/11/2020.
//

import UIKit

class FollowersListVC: UIViewController {

    //MARK: Section Enum
    enum Section { case main }
    
    
    //MARK: Properties
    var username: String!
    var followers = [Follower]()
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    
    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getFollowers()
        configureDataSource()
    }
    
    
    //MARK: View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    //MARK: Collection View Controller
    fileprivate func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    //MARK: Configure Collection View
    fileprivate func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(GFFollowerCell.self, forCellWithReuseIdentifier: GFFollowerCell.reuseId)
    }
    
    
    //MARK: Get Followers
    fileprivate func getFollowers() {
        NetworkManager.shared.getFollowers(for: username, page: 1) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let followers):
                self.followers = followers
                self.updateData()
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad Stuff Happened", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    
    //MARK: Configure Data Source
    fileprivate func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GFFollowerCell.reuseId, for: indexPath) as! GFFollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    
    //MARK: Update Data
    fileprivate func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}
