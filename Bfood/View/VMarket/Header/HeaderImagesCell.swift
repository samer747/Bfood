//
//  HeaderImagesCell.swift
//  Bfood
//
//  Created by samer on 7/30/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

class HeaderImagesCell: UICollectionViewCell {
    let image : UIImageView = {
        let i = UIImageView()
        i.layer.cornerRadius = 10
        i.clipsToBounds = true
        i.contentMode = .scaleAspectFill
        i.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        i.layer.borderColor = UIColor.darkGray.cgColor
        i.layer.borderWidth = 0.5
        i.image = #imageLiteral(resourceName: "collection-vegetables-isolated-white-background_44074-1573")
        return i
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //Shadows
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 10
        layer.shadowColor = .some(UIColor.green.cgColor)
        layer.shouldRasterize = true //to improve the fps rate and preformance while showing the shadows
        
        layer.cornerRadius = 10
        
        addSubview(image)
        image.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
