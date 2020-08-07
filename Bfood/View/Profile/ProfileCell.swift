//
//  ProfileCell.swift
//  Bfood
//
//  Created by samer on 7/29/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

class ProfileCell: UICollectionViewCell {
    //MARK: ----------- Variables ----------------
    let itemImage : UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    let itemLable : UILabel = {
        let l = UILabel()
        l.textColor = .label
        l.font = UIFont.systemFont(ofSize: 16)
        l.text = "text test sda"
        l.textAlignment = .left
        return l
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupLayout()
    {
        addSubview(itemImage)
        addSubview(itemLable)
        
        itemImage.centerYInSuperview()
        itemImage.anchorBySize(top: nil, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 15, bottom: 0, right: 0), size: .init(width: 40, height: 40))
        
        itemLable.centerYInSuperview()
        itemLable.anchorBySize(top: nil, leading: itemImage.trailingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 10, bottom: 0, right: 10))
    }
    
}
