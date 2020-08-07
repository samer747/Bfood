//
//  VMarketHeader.swift
//  Bfood
//
//  Created by samer on 7/30/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

class VMarketHeader: UICollectionReusableView {
    
    let lable : UILabel = {
       let l = UILabel()
        
        let attText = NSMutableAttributedString(attributedString: NSAttributedString(string: "Hot", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 35),NSAttributedString.Key.foregroundColor: UIColor(named: "NavCustomGreen") ?? "Black"]))
        
        attText.append(NSAttributedString(string: "Sales", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 35),NSAttributedString.Key.foregroundColor: UIColor.label]))
        l.attributedText = attText
        l.numberOfLines = 1
        return l
    }()
    
    let vMarketHeaderController = VMarketHeaderController()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(lable)
        addSubview(vMarketHeaderController.view)
        
        lable.anchorBySize(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 16, bottom: 0, right: 16), size: .zero)
        vMarketHeaderController.view.anchorBySize(top: lable.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: .zero)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
