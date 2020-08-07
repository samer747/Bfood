//
//  CartController.swift
//  Bfood
//
//  Created by samer on 8/3/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit
import Firebase

class CartController: UICollectionViewController , UICollectionViewDelegateFlowLayout {
    //MARK: ------- Variables ----------
    let cellID = "nikjmkl"
    
    var IDS = [String]()
    
    let refreshController : UIRefreshControl = {
        let r = UIRefreshControl()
        r.addTarget(self, action: #selector(handleRefrech), for: .valueChanged)
        return r
    }()
    //MARK: ------- ViewDidLoad ----------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchIDS()
        
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "CART"
        
        collectionView.refreshControl = refreshController
        collectionView.backgroundColor = .systemBackground
        
        collectionView.register(CartCell.self, forCellWithReuseIdentifier: cellID)
    }
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func handleRefrech(){
        self.IDS.removeAll()
        self.fetchIDS()
        self.collectionView.reloadData()
    }
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    //MARK: ------- CellSetup ----------
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 100)
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return IDS.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CartCell
        cell.imageView.sd_setImage(with: URL(string: "https://picsum.photos/id/\(indexPath.item)/68/68"))
        cell.id = self.IDS[indexPath.item]
        cell.tarshBtn.addTarget(self, action: #selector(deleteProductAction), for: .touchUpInside)
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Services.shared.fetchBrewerieByID(id: IDS[indexPath.item]) { (br, err) in
            if let err = err {
                print(err)
                return
            }
            DispatchQueue.main.async {
                let baseProductDetailsController = BaseProductDetailsController()
                baseProductDetailsController.brewerie = br
                self.present(baseProductDetailsController, animated: true, completion: nil)
            }
        }
    }
    //MARK: ------- Methods ----------
    @objc private func deleteProductAction(sender: UIButton)
    {
        guard let cell = sender.superview?.superview as? CartCell else { return }
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        
        let deleteID = self.IDS[indexPath.item]
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Database.database().reference().child("Cart").child(uid).child(deleteID).removeValue()
        
        
       handleRefrech()
    }
    private func fetchIDS()
    {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Database.database().reference().child("Cart").child(uid).observe(.value) { (snapshot) in
            guard let value = snapshot.value as? [String:Any] else { return }
            self.IDS.removeAll()
            value.forEach { (key,val) in
                self.IDS.append(key)
                self.collectionView.reloadData()
            }
        }
        refreshController.endRefreshing()
    }
}
