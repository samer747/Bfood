//
//  SMarketCell.swift
//  Bfood
//
//  Created by samer on 8/1/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

class SMarketHeaderCell: UICollectionViewCell {
    
    let viewLale : UIView = {
       let v = UIView()
        v.backgroundColor = .black
        v.alpha = 0.6
        v.layer.cornerRadius = 10
        return v
    }()
    let catgorieLable : UILabel = {
       let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = .white
        l.font = UIFont.boldSystemFont(ofSize: 25)
        return l
    }()
    
    let imageView : UIImageView = {
    let i = UIImageView()
        i.backgroundColor = .gray
        i.clipsToBounds = true
        i.layer.cornerRadius = 10
        i.contentMode = .scaleAspectFill
        return i
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.shadowColor = UIColor.systemGreen.cgColor
        layer.shadowRadius = 20
        layer.shadowOffset = .init(width: 0, height: -10)
        layer.shadowOpacity = 0
        
        layer.cornerRadius = 10
        
        
        addSubview(imageView)
        imageView.fillSuperview()
        
        addSubview(viewLale)
        viewLale.anchorBySize(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 80))
        
        addSubview(catgorieLable)
        catgorieLable.centerXAnchor.constraint(equalTo: viewLale.centerXAnchor).isActive = true
        catgorieLable.centerYAnchor.constraint(equalTo: viewLale.centerYAnchor).isActive = true
        
        
        
    }
    
    override var isSelected: Bool{
        didSet{
            if isSelected{
                viewLale.backgroundColor = .systemGreen
                layer.shadowOpacity = 0.5
            }
            else
            {
                viewLale.backgroundColor = .black
                layer.shadowOpacity = 0
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
