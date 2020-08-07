//
//  vMarketController.swift
//  Bfood
//
//  Created by samer on 7/28/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

private let cellID = "Cesadll"
private let headerID = "Celasdl"
private let footerID = "Cadssell"

class VMarketController: UICollectionViewController ,UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    //MARK: ------------- Variables -----------------
    let sectionsArray = [
    "Top Selling",
    "Most Visited",
    "New Products"
    ]
    
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    //MARK: ------------- ViewDidLoad -----------------
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.backgroundColor = .systemBackground
        
        self.collectionView!.register(VMarketCell.self, forCellWithReuseIdentifier: cellID)
        self.collectionView.register(VMarketHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID)
        self.collectionView.register(VMarketFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerID)
        
            setupSearchBar()
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    //MARK: ------------- CellSetup -----------------
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! VMarketCell
    
        cell.lable.text = sectionsArray[indexPath.item]
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 360)
    }
    
    //MARK: ------------- Header & Footer Setup -----------------
    // Kind For Item
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        //Header
        case UICollectionView.elementKindSectionHeader:

            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID, for: indexPath) as! VMarketHeader
            
            return header

        //Footer
        case UICollectionView.elementKindSectionFooter:
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerID, for: indexPath) as! VMarketFooter
            return footerView
        
        default:
            assert(false, "Unexpected element kind")
        }
    }
    //Header Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 300)
    }
    //FooterSize
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 360)
    }
    //MARK: ------------- Methods -----------------
    @objc private func searchButtonPressed()
    {
        print("sdaasads")
    }
    
    private func setupSearchBar(){
        searchController.searchBar.searchTextField.backgroundColor = .systemBackground
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
    }

}
