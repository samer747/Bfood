//
//  CartCell.swift
//  Bfood
//
//  Created by samer on 8/3/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

class CartCell: UICollectionViewCell {
    
    var id : String?{
        didSet{
            Services.shared.fetchBrewerieByID(id: id ?? "1") { (br, err) in
                if let err = err {
                    print(err)
                    return
                }
                DispatchQueue.main.async {
                    self.nameLable.text = br?.name
                }
            }
        }
    }
    
    //MARK: ------- Conponts ----------
    let sepretor : UIView = {
        let v = UIView()
        v.backgroundColor = .green
        return v
    }()
    let imageView : UIImageView = {
        let i = UIImageView()
        i.backgroundColor = #colorLiteral(red: 0.4414199293, green: 0.8256766796, blue: 0.3474115729, alpha: 1)
        i.layer.cornerRadius = 10
        i.clipsToBounds = true
        i.contentMode = .scaleAspectFill
        i.widthAnchor.constraint(equalToConstant: 68).isActive = true
        i.heightAnchor.constraint(equalToConstant: 68).isActive = true
        return i
    }()
    let nameLable : UILabel = {
        let l = UILabel()
        l.text = "sadsdas"
        l.textColor = .label
        l.font = UIFont.boldSystemFont(ofSize: 18)
        return l
    }()
    let tarshBtn : UIButton = {
        let b = UIButton(type: .system)
        b.setImage(UIImage(named: "trash"), for: .normal)
        b.widthAnchor.constraint(equalToConstant: 68).isActive = true
        b.heightAnchor.constraint(equalToConstant: 68).isActive = true
        b.imageView?.contentMode = .scaleAspectFill
        b.imageView?.tintColor = .red
        b.imageView?.clipsToBounds = true
        return b
    }()
    //MARK: ------- Init ----------
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        let stack = CustomStackView(arrangedSubviews: [imageView,nameLable,tarshBtn], spacing: 10, axis: .horizontal, dis: .fill)
        addSubview(stack)
        stack.anchorBySize(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 16, left: 16, bottom: 16, right: 16), size: .zero)
        
        addSubview(sepretor)
        sepretor.anchorBySize(top: nil, leading: nameLable.leadingAnchor , bottom: imageView.bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 00, right: 0), size: .init(width: 0, height: 1))
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
