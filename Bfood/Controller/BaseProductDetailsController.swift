//
//  BaseProductDetailsController.swift
//  Bfood
//
//  Created by samer on 8/2/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit
import Firebase

class BaseProductDetailsController: UICollectionViewController {
    
    
    //MARK: --------------------- variables ---------------------
    var brewerie : Brewerie?{
        didSet{
            guard let br = brewerie else { return }
            coverImageView.sd_setImage(with: URL(string: "https://picsum.photos/400/200"))
            profileImageView.sd_setImage(with: URL(string: "https://picsum.photos/200"))
            
            
            idLable.text = "ID : \(br.id)"
            nameLable.text = br.name
            typeLable.text = br.brewery_type
            countryLable.text = br.country
            phoneLable.text = "Contact: \(br.phone ?? "")"
            siteLable.text = "\(br.website_url ?? "")"
            dateLable.text = "Last Update: \(br.updated_at ?? "")"
            fetchCart()
        }
    }
    
    var onDoneBlock : ((Bool) -> Void)?

 //MARK: --------------------- Lables ---------------------
    
    let nameLable : UILabel = {
       let l = UILabel()
        l.text = ""
        l.font = UIFont.boldSystemFont(ofSize: 25)
        l.textAlignment = .center
        l.textColor = .label
        l.numberOfLines = 1
        return l
    }()
    let typeLable : UILabel = {
       let l = UILabel()
        l.text = ""
        l.font = UIFont.systemFont(ofSize: 20)
        l.textColor = .systemGreen
        l.textAlignment = .center
        l.numberOfLines = 1
        return l
    }()
    let countryLable : UILabel = {
       let l = UILabel()
        l.text = ""
        l.font = UIFont.systemFont(ofSize: 15)
        l.textColor = .systemGray2
        l.numberOfLines = 1
        l.textAlignment = .center
        return l
    }()
    let phoneLable : UILabel = {
       let l = UILabel()
        l.text = ""
        l.font = UIFont.preferredFont(forTextStyle: .headline)
        l.textColor = .systemGray3
        l.numberOfLines = 1
        l.textAlignment = .center
        return l
    }()
    let siteLable : UILabel = {
       let l = UILabel()
        l.text = ""
        l.font = UIFont.preferredFont(forTextStyle: .headline)
        l.textColor = .link
        l.numberOfLines = 1
        l.textAlignment = .center
        return l
    }()
    let dateLable : UILabel = {
       let l = UILabel()
        l.text = ""
        l.font = UIFont.preferredFont(forTextStyle: .headline)
        l.textColor = .systemGray3
        l.numberOfLines = 1
        l.textAlignment = .center
        return l
    }()
    let idLable : UILabel = {
        let l = UILabel()
        l.text = ""
        l.font = UIFont.systemFont(ofSize: 15)
        l.textColor = .systemGray3
        l.numberOfLines = 1
        l.textAlignment = .center
        return l
    }()
//-----------------------------------------------------------------------------------------------
    
    let coverImageView : UIImageView = {
       let i = UIImageView()
        i.contentMode = .scaleAspectFill
        i.clipsToBounds = true
        i.layer.cornerRadius = 10
        i.backgroundColor = .systemGray5
        return i
    }()
    let profileImageView : UIImageView = {
       let i = UIImageView()
        i.contentMode = .scaleAspectFill
        i.clipsToBounds = true
        i.layer.cornerRadius = 100
        i.layer.borderColor = UIColor.systemGray3.cgColor
        i.layer.borderWidth = 10
        i.backgroundColor = .systemGray4
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    
    let addToCartButton: UIButton = {
        let b = UIButton(type: .system)
        b.titleLabel?.font = .systemFont(ofSize: 15)
        b.backgroundColor = .systemGreen
        b.setTitle("Add to Cart", for: .normal)
        b.layer.cornerRadius = 50
        b.layer.shadowColor = UIColor.label.cgColor
        b.layer.shadowRadius = 50
        b.layer.shadowOpacity = 1
        b.layer.shadowOffset = .init(width: 0, height: 40)
        b.layer.borderColor = UIColor.label.cgColor
        b.layer.borderWidth = 3
        b.addTarget(self, action: #selector(addToCartAction), for: .touchUpInside)
        b.setTitleColor(.label, for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.isHidden = true
        return b
    }()
    let removeFromCartButton: UIButton = {
        let b = UIButton(type: .system)
        b.titleLabel?.font = .boldSystemFont(ofSize: 15)
        b.backgroundColor = .systemGray
        b.setTitle("Remove", for: .normal)
        b.layer.cornerRadius = 50
        b.layer.shadowColor = UIColor.systemRed.cgColor
        b.layer.shadowRadius = 50
        b.layer.shadowOpacity = 1
        b.layer.shadowOffset = .init(width: 0, height: 40)
        b.layer.borderColor = UIColor.label.cgColor
        b.layer.borderWidth = 3
        b.addTarget(self, action: #selector(addToCartRemoveAction), for: .touchUpInside)
        b.setTitleColor(.label, for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.isHidden = true
        return b
    }()
    
    //MARK: ------------ ViewDidLoad ---------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .systemBackground
        
        addAllSubViews()
    }
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        onDoneBlock?(true)
    }
    override var prefersStatusBarHidden: Bool{
        return true
    }
    //MARK: ------ Methods ------
    @objc private func addToCartAction(){   //ADD
        addToCartButton.isEnabled = false
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let intID = self.brewerie?.id else { return }
        let productID = "\(intID)"
        
        let value = ["productID": 1]
        
        Database.database().reference().child("Cart").child(uid).child(productID).updateChildValues(value) { (err, _) in
            if let err = err {
                print(err)
                return
            }
        }
        fetchCart()
        addToCartButton.isEnabled = true
    }
    @objc private func addToCartRemoveAction(){ //Remove
        addToCartButton.isEnabled = false
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let intID = self.brewerie?.id else { return }
        let productID = "\(intID)"
        
        Database.database().reference().child("Cart").child(uid).child(productID).removeValue()
        
        fetchCart()
        addToCartButton.isEnabled = true
    }
    private func fetchCart()
    {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let intID = self.brewerie?.id else { return }
        let productID = "\(intID)"
        
        let ref = Database.database().reference().child("Cart").child(uid).child(productID).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? [String: Int] ?? ["productID": 0]
            
            if value["productID"] == 1{//el product fe el cart
                self.addToCartButton.isHidden = true
                self.removeFromCartButton.isHidden = false
            }else{
                self.addToCartButton.isHidden = false
                self.removeFromCartButton.isHidden = true
            }
            
        }) { (err) in
            print(err)
        }
        
        
       
    }
    //MARK: ----------- LayOuts --------------
    fileprivate func addAllSubViews() {
        view.addSubview(coverImageView)
        view.addSubview(profileImageView)
        view.addSubview(addToCartButton)
        view.addSubview(removeFromCartButton)
        imagesSetupLayouts()
        
        view.addSubview(idLable)
        view.addSubview(nameLable)
        view.addSubview(typeLable)
        view.addSubview(countryLable)
        lablesSetupLayouts()
    }
    
    
    fileprivate func imagesSetupLayouts() {
        coverImageView.anchorBySize(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 200))
        
        
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: coverImageView.bottomAnchor).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        addToCartButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addToCartButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        addToCartButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        addToCartButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        removeFromCartButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        removeFromCartButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        removeFromCartButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        removeFromCartButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    fileprivate func lablesSetupLayouts()
    {
        idLable.anchorBySize(top: coverImageView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: profileImageView.leadingAnchor, padding: .init(top: 70, left: 10, bottom: 0, right: 10), size: .zero)
        
        nameLable.anchorBySize(top: profileImageView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 16, left: 16, bottom: 0, right: 16), size: .zero)
        
        typeLable.anchorBySize(top: nameLable.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 16), size: .zero)
        
        countryLable.anchorBySize(top: coverImageView.bottomAnchor, leading: profileImageView.trailingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 70, left: -15, bottom: 0, right: 10), size: .zero)
        
        let stack = CustomStackView(arrangedSubviews: [phoneLable,siteLable,dateLable], spacing: 0, axis: .vertical, dis: .fillEqually)
        view.addSubview(stack)
        stack.anchorBySize(top: typeLable.bottomAnchor, leading: view.leadingAnchor, bottom: addToCartButton.topAnchor, trailing: view.trailingAnchor, padding: .init(top: 16, left: 0, bottom: 16, right: 0), size: .zero)
        
    }
    
}
