//
//  VMarketFooter.swift
//  Bfood
//
//  Created by samer on 7/30/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

class VMarketFooter: UICollectionReusableView {
    
    let lable : UILabel = {
       let l = UILabel()
        l.textColor = UIColor(named: "NavCustomGreen")
        l.font = UIFont.boldSystemFont(ofSize: 35)
        l.text = "Sections"
        l.numberOfLines = 1
        return l
    }()
        
    let vMarketFooterController = VMarketFooterController(collectionViewLayout: UICollectionViewFlowLayout())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(lable)
        addSubview(vMarketFooterController.view)
        
        lable.anchorBySize(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 16, left: 16, bottom: 0, right: 16), size: .zero)
        vMarketFooterController.view.anchorBySize(top: lable.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .zero)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
