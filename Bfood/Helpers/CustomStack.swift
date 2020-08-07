//
//  CustomStack.swift
//  Bfood
//
//  Created by samer on 7/28/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

class CustomStackView: UIStackView {

    init(arrangedSubviews: [UIView], spacing: CGFloat = 0,axis: NSLayoutConstraint.Axis,dis: UIStackView.Distribution) {
        super.init(frame: .zero)
        
        arrangedSubviews.forEach({addArrangedSubview($0)})
        self.distribution = dis
        self.spacing = spacing
        self.axis = axis
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
