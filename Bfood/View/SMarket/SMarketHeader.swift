//
//  SMarketHeader.swift
//  Bfood
//
//  Created by samer on 8/1/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

class SMarketHeader: UICollectionReusableView {
    
    let sMarketHeaderController = SMarketHeaderController(collectionViewLayout: UICollectionViewFlowLayout())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
        addSubview(sMarketHeaderController.view)
        sMarketHeaderController.view.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
