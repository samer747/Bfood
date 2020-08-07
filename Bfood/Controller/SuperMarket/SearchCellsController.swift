//
//  File.swift
//  Bfood
//
//  Created by samer on 8/1/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

protocol searchConDelegate {
    func searchCellPressed(id: String)
}

class SearchCellsController: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    let randInd = Int.random(in: 1...900)
    let cellID = "ssaddsadsa"
    
    var delegate : searchConDelegate?
    
    var filterdAutoBrewerieResult = [AutoBrewerieResult]()
    
    let lable : UILabel = {
       let l = UILabel()
        l.text = "Enter search path"
        l.textColor = .label
        l.font = UIFont.systemFont(ofSize: 20)
        return l
    }()
    
    let blurV : UIVisualEffectView = {
        let v = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        v.backgroundColor = #colorLiteral(red: 0.8390926719, green: 0.9391269088, blue: 0.7828452587, alpha: 1)
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundView = blurV
        
        view.addSubview(lable)
        lable.centerInSuperview()
        
        collectionView.backgroundColor = .clear
       
        collectionView.register(SearchCell.self, forCellWithReuseIdentifier: cellID)
    }
    //MARK: ------------ CellsSetup ------------
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 100)
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SearchCell
        cell.autoBrewerieResult = filterdAutoBrewerieResult[indexPath.item]
        cell.imageView.sd_setImage(with: URL(string: "https://picsum.photos/id/\(randInd+indexPath.item)/68/68"))
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterdAutoBrewerieResult.count
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let id = filterdAutoBrewerieResult[indexPath.item].id
        delegate?.searchCellPressed(id: id)
    }
}
