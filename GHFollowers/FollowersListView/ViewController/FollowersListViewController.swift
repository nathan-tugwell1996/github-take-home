//
//  FollowersListViewController.swift
//  GHFollowers
//
//  Created by Nathan Tugwell on 10/07/2022.
//

import UIKit

class FollowersListViewController: UIViewController {

    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        NetworkManager.shared.getFollowers(for: username, page: 1) { followers, errorMessage in
            guard let followers = followers else {
                self.presentNTAlertOnMainThread(title: "Shit", message: errorMessage!, buttonTitle: "Ok")
                return
            }
            
            print(followers.count)
            print(followers)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
