//
//  User.swift
//  GHFollowers
//
//  Created by Nathan Tugwell on 11/07/2022.
//

import Foundation

struct User: Codable {
    let login: String
    let avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    let publicRepos: Int
    let publicGists: Int
    let htmlUrl: String
    let followers: Int
    let following: Int
    let createAt: String
}
