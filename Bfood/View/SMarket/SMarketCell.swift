//
//  SMarketCell.swift
//  Bfood
//
//  Created by samer on 8/1/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit


class SMarketCell: UICollectionViewCell {
    
    
    
    var brewerie : Brewerie?{
        didSet{
            nameLable.text = brewerie?.name
            typeLable.text = brewerie?.brewery_type
            countryLable.text = brewerie?.country
        }
    }
    
    let nameLable : UILabel = {
       let l = UILabel()
        l.text = "sadsdas"
        l.textColor = .label
        l.font = UIFont.boldSystemFont(ofSize: 18)
        return l
    }()
    let typeLable : UILabel = {
       let l = UILabel()
        l.text = "sadsdas"
        l.textColor = #colorLiteral(red: 0.4168642759, green: 0.7854617238, blue: 0.3510575593, alpha: 1)
        l.font = UIFont.systemFont(ofSize: 15)
        return l
    }()
    let countryLable : UILabel = {
       let l = UILabel()
        l.text = "sadsdas"
        l.textColor = .systemGray4
        l.font = UIFont.systemFont(ofSize: 15)
        return l
    }()
    
    
    let imageView : UIImageView = {
    let i = UIImageView()
        i.backgroundColor = #colorLiteral(red: 0.3010234237, green: 0.2742826939, blue: 0.2748436034, alpha: 1)
        i.layer.cornerRadius = 10
        i.clipsToBounds = true
        i.contentMode = .scaleAspectFill
        i.widthAnchor.constraint(equalToConstant: 68).isActive = true
        i.heightAnchor.constraint(equalToConstant: 68).isActive = true
        return i
    }()
    
    let viewButton : UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("View", for: .normal)
        b.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        b.setTitleColor(#colorLiteral(red: 0.9609368443, green: 0.9189221263, blue: 0.9180728197, alpha: 1), for: .normal)
        b.backgroundColor = #colorLiteral(red: 0.3575871587, green: 0.3391513824, blue: 0.3374176621, alpha: 1)
        b.layer.cornerRadius = 35
        b.heightAnchor.constraint(equalToConstant: 68).isActive = true
        b.widthAnchor.constraint(equalToConstant: 168).isActive = true
        
        return b
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let lablesStack = CustomStackView(arrangedSubviews: [nameLable,typeLable,countryLable], spacing: 2, axis: .vertical, dis: .fill)
        
        let allStack = CustomStackView(arrangedSubviews: [imageView,lablesStack,viewButton], spacing: 16, axis: .horizontal, dis: .fill)
        addSubview(allStack)
        allStack.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: -35))
    }
   
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
