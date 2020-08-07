//
//  VMarketCellController.swift
//  Bfood
//
//  Created by samer on 7/30/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

private let reuseIdentifier = "dassaddas"

class VMarketCellController: HSnappingController , UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.backgroundColor = .systemBackground
        
        self.collectionView!.register(CellProductCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        
        collectionView.showsHorizontalScrollIndicator = false
    }

    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return 6
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CellProductCell
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width / 2) - 20, height: 280)
    }


}
