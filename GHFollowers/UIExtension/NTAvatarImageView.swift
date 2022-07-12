//
//  NTAvatarImageView.swift
//  GHFollowers
//
//  Created by Nathan Tugwell on 12/07/2022.
//

import UIKit

class NTAvatarImageView: UIImageView {
    
    let placeholderImage = UIImage(named: "avatar-placeholder")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }

}
