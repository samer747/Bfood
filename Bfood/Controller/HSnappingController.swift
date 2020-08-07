//
//  File.swift
//  Bfood
//
//  Created by samer on 7/28/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

//34an yzbot el horzontl swiping w lazm t3ml content insits b2a fe el class ely b inhirt mn da
/*
 collectionView.contentInset = .init(top: 0, left: 14, bottom: 0, right: 14)
 */
class HSnappingController: UICollectionViewController {
    
    init() {
        let layout = BetterSnappingLayout()
        layout.scrollDirection = .horizontal
        super.init(collectionViewLayout: layout)
        collectionView.decelerationRate = .fast //bt7ded sor3et el scroll
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
