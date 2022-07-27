//
//  NTEmptyStateUIView.swift
//  GHFollowers
//
//  Created by Nathan Tugwell on 14/07/2022.
//

import UIKit

class NTEmptyStateUIView: UIView {
    
    let messageLabel = NTTitleLabel(textAlignment: .center, fontSize: 28)
    let logoImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(messageLabel)
        addSubview(logoImageView)
        
        
    }
    
}
