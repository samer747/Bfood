//
//  ProfileFooter.swift
//  Bfood
//
//  Created by samer on 7/28/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

class ProfileFooter: UICollectionReusableView {
    //MARK: ----------- Variables ----------------
    let logoImage : UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = #imageLiteral(resourceName: "BfoodLogo")
        return iv
    }()
    let lable1 : UILabel = {
        let l = UILabel()
        l.text = "app gamed neek samer ely 3amlo b7bk ya kashmeer"
        l.textColor = .lightGray
        l.font = UIFont.systemFont(ofSize: 12)
        l.textAlignment = .center
        return l
    }()
    let lable2 : UILabel = {
        let l = UILabel()
        l.text = "Privacy Policy | Terms and conditions"
        l.textColor = .systemBlue
        l.font = UIFont.systemFont(ofSize: 14)
        l.textAlignment = .center
        return l
    }()
    let lable3 : UILabel = {
        let l = UILabel()
        l.text = "All copyrights @ 2020 thamora.com . Allrights recived"
        l.textColor = .lightGray
        l.font = UIFont.systemFont(ofSize: 11)
        l.textAlignment = .center
        return l
    }()
    //MARK: ----------- Init ----------------
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(named: "footerAndHeaderColor")
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: ----------- Methods ----------------
    private func setupLayout(){
        addSubview(logoImage)
        addSubview(lable1)
        addSubview(lable2)
        addSubview(lable3)
        
        logoImage.centerXInSuperview()
        logoImage.anchorBySize(top: topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: .init(width: 80, height: 80))
        
        lable1.anchorBySize(top: logoImage.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 0, bottom: 10, right: 10))
        
        lable3.anchorBySize(top: nil, leading: leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 10, bottom: 10, right: 10))
        
        lable2.anchorBySize(top: nil, leading: leadingAnchor, bottom: lable3.topAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 10, bottom: 20, right: 10))
    }
}
