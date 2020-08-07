//
//  sMarketController.swift
//  Bfood
//
//  Created by samer on 7/28/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit
import Firebase

private let cellID = "Cesadsll"
private let headerID = "Celsasdl"


class SMarketController: UICollectionViewController ,UICollectionViewDelegateFlowLayout,SHeaderDelegate, UISearchBarDelegate , searchConDelegate{
    
    
    //MARK: ------------------ Variables ------------------
    var selectedType : SelectedType = .micro
    var brewerieList = [Brewerie]()
    let indecator = UIActivityIndicatorView(style: .large)
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    let refreshController : UIRefreshControl = {
        let r = UIRefreshControl()
        r.addTarget(self, action: #selector(handleRefrech), for: .valueChanged)
        return r
    }()
    var timer : Timer?
    let searchCellsController = SearchCellsController(collectionViewLayout: UICollectionViewFlowLayout())
    
    let cartNumLable : UILabel = {
        let l = UILabel()
        l.text = ""
        l.font = UIFont.systemFont(ofSize: 10)
        l.textColor = .white
        return l
    }()
    
    let cartNumView : UIView = {
       let v = UIView()
        v.backgroundColor = .systemRed
        v.layer.borderColor = UIColor.white.cgColor
        v.layer.borderWidth = 1
        v.layer.cornerRadius = 10
        return v
    }()
    
    let cartButton : UIButton = {
        let cb = UIButton(type: .system)
        cb.setImage(#imageLiteral(resourceName: "CartIcon"), for: .normal)
        cb.tintColor = .systemGreen
        return cb
    }()
    
    //MARK: ------------------ ViewDidLoad ------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayOuts()
        
        setupSearchBar()
        
        fireFetchingBrewerie()
        
        setupCartButton()
        
        fetchNumOfProducts()
        
        collectionView.backgroundColor = .systemBackground
        collectionView.showsVerticalScrollIndicator = false
        collectionView.refreshControl = refreshController
        
        self.collectionView!.register(SMarketCell.self, forCellWithReuseIdentifier: cellID)
        self.collectionView.register(SMarketHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID)
    }
    
    override var prefersStatusBarHidden: Bool {return true}
    //MARK: ------------------ SetupCells ------------------
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return brewerieList.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SMarketCell
        
        cell.brewerie = self.brewerieList[indexPath.item]
        if cell.imageView.image == nil
        {
        cell.imageView.sd_setImage(with: URL(string: "https://picsum.photos/id/\(Int.random(in: 0...900)+indexPath.item)/68/68"))
        }
        cell.viewButton.addTarget(self, action: #selector(viewButtonPressed(sender:)), for: .touchUpInside)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
    
    //MARK: ------------- Header Setup -----------------
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID, for: indexPath) as! SMarketHeader
        header.backgroundColor = .black
        header.sMarketHeaderController.sHeaderDelegate = self
        return header
        
    }
    //Header Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 270)
    }
    
    //MARK: ------------------ Methods ------------------
    @objc private func handleRefrech(){
        self.brewerieList.removeAll()
        fireFetchingBrewerie()
        fetchNumOfProducts()
        self.collectionView.reloadData()
    }
    
    private func fetchBrewerie(completion : @escaping ([Brewerie]?,Error?) -> Void){
        Services.shared.fetchGenericJSONData(Url: "https://api.openbrewerydb.org/breweries?by_type=\(selectedType)", completion: completion)
        
    }
    
    
    fileprivate func fireFetchingBrewerie() {
        fetchBrewerie { (brewerie, err) in
            if let err = err {
                print(err)
                return
            }
            self.brewerieList = brewerie ?? []
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.indecator.stopAnimating()
            }
        }
    }
    
    
    func typeChanged(type: SelectedType) {
        if self.selectedType == type{
            return
        }
        self.selectedType = type
        self.brewerieList.removeAll()
        self.indecator.startAnimating()
        self.fireFetchingBrewerie()
        DispatchQueue.main.async {
            
            self.collectionView.reloadData()
        }
    }
    
    @objc func viewButtonPressed(sender: UIButton)
    {
        guard let cell = sender.superview?.superview as? SMarketCell else { //34an ageeb el cell
            return // or fatalError() or whatever
        }

        guard let indexPath = collectionView.indexPath(for: cell) else { return } //gbna el index bta3 el cell
        let baseProductDetailsController = BaseProductDetailsController()
        baseProductDetailsController.brewerie = self.brewerieList[indexPath.item]
        baseProductDetailsController.onDoneBlock = { result in
            self.handleRefrech()
        }
        present(baseProductDetailsController,animated: true)
    }
    func searchCellPressed(id: String) {
        
        Services.shared.fetchBrewerieByID(id: id ) { (br, err) in
            if let err = err {
                print(err)
                return
            }
            
            let baseProductDetailsController = BaseProductDetailsController()
            baseProductDetailsController.brewerie = br
            DispatchQueue.main.async {
                self.present(baseProductDetailsController,animated: true)
                self.navigationItem.searchController?.dismiss(animated: true)
                self.searchController.searchBar.text = ""
            }
        }
    }
    private func fetchNumOfProducts(){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Database.fetchNumOfProductsInCart(uid: uid) { (num) in
            self.cartNumLable.text = "\(num)"
            
            if self.cartNumLable.text != ""{
            self.cartButton.addSubview(self.cartNumView)
            self.cartNumView.anchorBySize(top: self.cartButton.topAnchor, leading: nil, bottom: nil, trailing: self.cartButton.trailingAnchor, padding: .init(top: -3, left: 0, bottom: 0, right: -10), size: .init(width: 20, height: 20))
            }
        }
        refreshController.endRefreshing()
        self.collectionView.reloadData()
    }
    //MARK: --------- SearchBar ----------
    fileprivate func setupSearchBar()
    {
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.searchTextField.backgroundColor = .systemBackground
        searchController.searchBar.searchTextField.textColor = .label
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        UIView.animate(withDuration: 0.7, delay: 0, options: .curveEaseOut, animations: {
            
            self.searchCellsController.view.transform = .init(translationX: 0, y: self.searchCellsController.view.frame.height + searchBar.frame.height + statusBarHeight)
        })
        collectionView.isScrollEnabled = false
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == ""{
            self.searchCellsController.lable.isHidden = false
            self.searchCellsController.filterdAutoBrewerieResult.removeAll()
            DispatchQueue.main.async {
                self.searchCellsController.collectionView.reloadData()
            }
        }else{
            self.searchCellsController.lable.isHidden = true
            
            
            timer?.invalidate() // da 34an lw ktbna bsor3a my7fz4 w lma el time y5ls yfire kolo
            timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { (_) in
                Services.shared.fetchAutoComplete(query: searchText) { (resArr, err) in
                    if let err = err {
                        print("Error fetching auto Complete: ",err)
                        return
                    }
                    self.searchCellsController.filterdAutoBrewerieResult.removeAll()
                    self.searchCellsController.filterdAutoBrewerieResult = resArr ?? []
                    DispatchQueue.main.async {
                        self.searchCellsController.collectionView.reloadData()
                    }
                }
            })
        }
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        UIView.animate(withDuration: 0.7, delay: 0, options: .curveEaseOut, animations: {
            self.searchCellsController.view.transform = .identity
        })
        collectionView.isScrollEnabled = true
        self.searchCellsController.lable.isHidden = false
        self.searchCellsController.filterdAutoBrewerieResult.removeAll()
        DispatchQueue.main.async {
            self.searchCellsController.collectionView.reloadData()
        }
    }
    //MARK: ---------- Layouts -----------
    
    fileprivate func setupLayOuts() {
        view.addSubview(searchCellsController.view)
        searchCellsController.delegate = self
        searchCellsController.view.anchorBySize(top: nil, leading: view.leadingAnchor, bottom: view.topAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: view.frame.width, height: 500))
        
        indecator.startAnimating()
        view.addSubview(indecator)
        indecator.anchorBySize(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 270, left: 0, bottom: 0, right: 0), size: .zero)
        
        
        
    }
    fileprivate func setupCartButton() {
        let allView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 60))

        allView.addSubview(cartButton)
        cartButton.anchorBySize(top: allView.topAnchor, leading: allView.leadingAnchor, bottom: allView.bottomAnchor, trailing: allView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 35, height: 35))
        
        
        if cartNumLable.text != ""{
        cartButton.addSubview(cartNumView)
        cartNumView.anchorBySize(top: cartButton.topAnchor, leading: nil, bottom: nil, trailing: cartButton.trailingAnchor, padding: .init(top: -3, left: 0, bottom: 0, right: -10), size: .init(width: 20, height: 20))
        }
        
        
        cartNumView.addSubview(cartNumLable)
        cartNumLable.centerInSuperview()
        
        cartButton.addTarget(self, action: #selector(goToCartButton), for: .touchUpInside)
        
        let backButton = UIBarButtonItem(customView: allView)
        navigationItem.rightBarButtonItem = backButton
        navigationItem.largeTitleDisplayMode = .never
    }
    @objc private func goToCartButton(){
        let cartController = CartController()
        navigationController?.pushViewController(cartController, animated: true)
    }
    
}
