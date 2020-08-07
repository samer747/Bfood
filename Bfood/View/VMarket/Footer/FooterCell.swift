//
//  FooterCell.swift
//  Bfood
//
//  Created by samer on 7/30/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

class FooterCell: UICollectionViewCell {
    
    let button : UIButton = {
        let b = UIButton(type: .system)
        b.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        b.setTitleColor(.label, for: .normal)
        return b
    }()
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(white: 0.2, alpha: 0.2)
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray.cgColor
        
        addSubview(button)
        button.fillSuperview()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
