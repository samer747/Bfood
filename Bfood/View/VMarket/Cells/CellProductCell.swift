//
//  CellProductCell.swift
//  Bfood
//
//  Created by samer on 7/30/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

class CellProductCell: UICollectionViewCell {
    
    let image : UIImageView = {
       let i = UIImageView()
        i.clipsToBounds = true
        i.contentMode = .scaleAspectFill
        i.layer.cornerRadius = 10
        i.image = #imageLiteral(resourceName: "potato-1-525x600")
        return i
    }()
    
    let nameLable : UILabel = {
      let l = UILabel()
        l.text = "Fresh Potato"
        l.font = UIFont.boldSystemFont(ofSize: 16)
        return l
    }()
    let PriceLable : UILabel = {
      let l = UILabel()
        l.text = "Price : 4.99$"
        l.font = UIFont.systemFont(ofSize: 16)
        return l
    }()
    
    let viewButton : UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("View", for: .normal)
        b.setTitleColor(.label, for: .normal)
        b.backgroundColor = UIColor(named: "NavCustomGreen")
        b.layer.cornerRadius = 10
        return b
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
        layer.borderWidth = 3
        layer.cornerRadius = 10
        
        backgroundColor = .systemGray4
        
        //Shadows
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 20
        layer.shadowColor = .some(UIColor.systemGreen.cgColor)
        layer.shouldRasterize = true //to improve the fps rate and preformance while showing the shadows
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupLayout()
    {
        
        image.heightAnchor.constraint(equalToConstant: 200).isActive = true
        image.widthAnchor.constraint(equalToConstant: frame.width).isActive = true
        viewButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        viewButton.widthAnchor.constraint(equalToConstant: frame.width - 10).isActive = true
        
        let stack = CustomStackView(arrangedSubviews: [image,nameLable,PriceLable,viewButton], spacing: 5, axis: .vertical, dis: .fill)
        stack.alignment = .center
        addSubview(stack)
        stack.fillSuperview()
    }
}
