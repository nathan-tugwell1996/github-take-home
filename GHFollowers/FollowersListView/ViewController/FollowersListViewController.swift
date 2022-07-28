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
    var page = 1
    var hasMoreFollowers = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureViewController()
        getFollowers(username: username, page: page)
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
        collectionView.delegate = self
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    func getFollowers(username: String, page: Int) {
        showActivityIndicator()
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
            guard let self = self else { return }
            self.hideActivityIndicator()
            switch result {
            case .success(let followers):
                if followers.count < 100 {
                    self.hasMoreFollowers = false
                }
                self.followers.append(contentsOf: followers)
                
                if self.followers.isEmpty {
                    let message = "This user has no followers. 😃"
                    
                    DispatchQueue.main.async {
                        self.showEmptyStateView(message: message, view: self.view)
                    }
                }
                
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


extension FollowersListViewController: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.height
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers else { return }
            page += 1
            getFollowers(username: username, page: page)
        }
    }
}
