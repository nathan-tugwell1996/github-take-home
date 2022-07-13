//
//  FollowersListViewController.swift
//  GHFollowers
//
//  Created by Nathan Tugwell on 10/07/2022.
//

import UIKit

class FollowersListViewController: UIViewController {
    
    enum Section {
        case main
    }

    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    var username: String!
    var followers: [Follower] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureViewController()
        getFollowers()
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureCollectionView() {
        let flow = CollectionViewLayoutHelper.createFlowLayout(in: view)
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flow)
        view.addSubview(collectionView)
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    func getFollowers() {
        NetworkManager.shared.getFollowers(for: username, page: 1) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let followers):
                self.followers = followers
                self.updateData()
            case .failure(let error):
                self.presentNTAlertOnMainThread(title: "Error", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}
