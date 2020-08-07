//
//  ProfileHeader.swift
//  Bfood
//
//  Created by samer on 7/28/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

protocol headerDelegate {
    func imagePressed()
}

class ProfileHeader: UICollectionReusableView  {
    
    //Delegate
    var delegate : headerDelegate?
    var user: User?{
        didSet{
            guard let user = user else { return }
            usernameLable.text = user.username
            
            guard let url = URL(string: user.profileImageUrl) else { return }
            
            URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                if let error = error {
                    print("Failed to load image from db:", error)
                    return
                }
                
                guard let imageData = data else { return }
                
                guard let photoImage = UIImage(data: imageData) else { return }
                
                
                
                DispatchQueue.main.async {
                    self!.profilePicButton.setImage(photoImage.withRenderingMode(.alwaysOriginal), for: .normal)
                    self!.i.image = self!.profilePicButton.imageView?.image
                }
            }.resume()
            
            
        }
    }
    //MARK: ----------- Variables ----------------
    let i = UIImageView()
    
    let profilePicButton : UIButton = {
        let iv = UIButton(type: .system)
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 40
        iv.layer.borderColor = UIColor.green.cgColor
        iv.layer.borderWidth = 0.5
        iv.setImage(#imageLiteral(resourceName: "Image"), for: .normal)
        iv.addTarget(self, action: #selector(imageButtonPressed), for: .touchUpInside)
        return iv
    }()
    let usernameLable : UILabel = {
        let l = UILabel()
        l.text = ""
        l.textColor = .black
        l.font = UIFont.preferredFont(forTextStyle: .headline)
        l.textAlignment = .center
        return l
    }()
    let emailLable : UILabel = {
        let l = UILabel()
        l.text = ""
        l.textColor = .black
        l.font = UIFont.preferredFont(forTextStyle: .headline)
        l.textAlignment = .center
        return l
    }()
    
    //MARK: ----------- init ----------------
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(named: "footerAndHeaderColor")
        setupLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: ----------- Setup ----------------
    private func setupLayout()
    {
        
        addSubview(i)
        i.fillSuperview()
        
        let x = UIVisualEffectView(effect: UIBlurEffect(style: .systemMaterialLight))
        x.alpha = 0.7
        addSubview(x)
        x.fillSuperview()
        
        
        
        addSubview(profilePicButton)
        profilePicButton.centerXInSuperview()
        profilePicButton.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
        profilePicButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        profilePicButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        
        let stack = CustomStackView(arrangedSubviews: [usernameLable,emailLable], spacing: 5, axis: .vertical, dis: .fill)
        addSubview(stack)
        stack.anchor(top: profilePicButton.bottomAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, leading: leadingAnchor, paddingLeft: 0, trailing: trailingAnchor, paddingRight: 0, width: 0, height: 0)
    }
    //MARK: ----------- Methods ----------------
    @objc func imageButtonPressed()
    {
        delegate?.imagePressed()
    }
    
}
