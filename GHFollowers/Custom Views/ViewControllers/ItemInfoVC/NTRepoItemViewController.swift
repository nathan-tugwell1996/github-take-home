//
//  NTRepoItemViewController.swift
//  GHFollowers
//
//  Created by Nathan Tugwell on 16/08/2022.
//

import UIKit

class NTRepoItemViewController: NTItemInfoViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(backgroundColour: .systemPurple, title: "GitHub Profile")
    }
}
