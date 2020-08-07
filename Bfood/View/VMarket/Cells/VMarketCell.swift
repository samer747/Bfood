//
//  VMarketCell.swift
//  Bfood
//
//  Created by samer on 7/30/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

class VMarketCell: UICollectionViewCell {
    let lable : UILabel = {
       let l = UILabel()
        l.textColor = UIColor(named: "NavCustomGreen")
        l.font = UIFont.boldSystemFont(ofSize: 35)
        l.numberOfLines = 1
        return l
    }()
    
    let vMarketCellController = VMarketCellController()
    
    let seprator : UIView = {
        let s = UIView()
        s.backgroundColor = .lightGray
       return s
    }()
    let seprator2 : UIView = {
        let s = UIView()
        s.backgroundColor = .lightGray
       return s
    }()
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(lable)
        addSubview(vMarketCellController.view)
        addSubview(seprator)
        addSubview(seprator2)
        
        lable.anchorBySize(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 16, bottom: 0, right: 16), size: .zero)
        
        seprator.anchorBySize(top: lable.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 1))
        
        vMarketCellController.view.anchorBySize(top: seprator.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 5, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 280))
        seprator2.anchorBySize(top: vMarketCellController.view.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 5, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 1))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
