//
//  NTFollowersViewController.swift
//  GHFollowers
//
//  Created by Nathan Tugwell on 16/08/2022.
//

import UIKit

class NTFollowersViewController: NTItemInfoViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.followers)
        actionButton.set(backgroundColour: .systemGreen, title: "Git Followers")
    }
}
