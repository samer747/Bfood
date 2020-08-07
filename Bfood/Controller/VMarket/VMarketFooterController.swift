//
//  VMarketFooterController.swift
//  Bfood
//
//  Created by samer on 7/30/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class VMarketFooterController: UICollectionViewController , UICollectionViewDelegateFlowLayout {
    
    let titlesArray = [
    "Salad",
    "Fruiting",
    "Squash",
    "Shooting",
    "Leafy",
    "Pod and Seed",
    "Bulb",
    "Root"
    ]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .systemBackground
        
        self.collectionView!.register(FooterCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return titlesArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FooterCell
    
        cell.button.setTitle(titlesArray[indexPath.item], for: .normal)
    
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ( view.frame.width / 2 ) - 22 , height: 60)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 16, bottom: 0, right: 16)
    }

}
