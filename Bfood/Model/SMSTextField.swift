//
//  SMSTextField.swift
//  Bfood
//
//  Created by samer on 7/28/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

class SMSTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configue()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configue(){
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 10
        layer.borderColor = UIColor.systemGray4.cgColor
        layer.borderWidth = 2
        
        textColor = .label //lable da abyd aw eswed depending on dark or light mode
        tintColor = .label // loon el curser
        font = UIFont.preferredFont(forTextStyle: .title2) //dynamic depending on users system font choice
        textAlignment = .center
        adjustsFontSizeToFitWidth = true //34an lw el user ktb kter el font yfdl ys8r kda 34an yb2a fit lel field
        minimumFontSize = 12 //34an el font myys8r4 awy
        
        backgroundColor = .secondarySystemBackground
        autocorrectionType = .no
        autocapitalizationType = .none
        
        
        
    }
    
}
