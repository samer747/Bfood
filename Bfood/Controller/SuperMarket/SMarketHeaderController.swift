//
//  File.swift
//  Bfood
//
//  Created by samer on 8/1/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

protocol SHeaderDelegate {
    func typeChanged(type: SelectedType)
}

class SMarketHeaderController: UICollectionViewController , UICollectionViewDelegateFlowLayout {
    
    var sHeaderDelegate : SHeaderDelegate?
    
    let CatgoriesList = [
    "Micro",
    "Regional",
    "Brewpub",
    "Large",
    "Planning",
    "Bar",
    "Contract",
    "Proprietor"
    ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        
        collectionView.register(SMarketHeaderCell.self, forCellWithReuseIdentifier: "samer")
        
        collectionView.backgroundColor = .systemBackground
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        
        collectionView.contentInset = .init(top: 20, left: 16, bottom: 0, right: 16)
        
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "samer", for: indexPath) as! SMarketHeaderCell
        
        cell.catgorieLable.text = CatgoriesList[indexPath.item]
        if cell.imageView.image == nil
        {
        let randomInt = Int.random(in: 0...900)
        cell.imageView.sd_setImage(with: URL(string: "https://picsum.photos/id/\(randomInt+indexPath.item)/170/250"))
        }
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CatgoriesList.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170, height: 250)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        switchType(indexPath)
        for x in 0...CatgoriesList.count-1 {
            
            let ind = NSIndexPath(index: x)
            guard let cell = collectionView.cellForItem(at: ind as IndexPath) as? SMarketHeaderCell else {return}
            cell.viewLale.backgroundColor = .black
            cell.layer.shadowOpacity = 0
            
        }
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? SMarketHeaderCell else {return}
        cell.viewLale.backgroundColor = .systemGreen
        cell.layer.shadowOpacity = 1
    }
    
    fileprivate func switchType(_ indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            sHeaderDelegate?.typeChanged(type: .micro)
        case 1:
            sHeaderDelegate?.typeChanged(type: .regional)
        case 2:
            sHeaderDelegate?.typeChanged(type: .brewpub)
        case 3:
            sHeaderDelegate?.typeChanged(type: .large)
        case 4:
            sHeaderDelegate?.typeChanged(type: .planning)
        case 5:
            sHeaderDelegate?.typeChanged(type: .bar)
        case 6:
            sHeaderDelegate?.typeChanged(type: .contract)
        case 7:
            sHeaderDelegate?.typeChanged(type: .proprietor)
            
        default:
            sHeaderDelegate?.typeChanged(type: .micro)
        }
    }
    
}
