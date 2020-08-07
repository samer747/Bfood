//
//  BaseTabBarVController.swift
//  Bfood
//
//  Created by samer on 7/28/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit
import Firebase

class BaseTabBarVController: UITabBarController {

    
    //MARK: ----------- viewDidLoad ----------------
    override func viewDidLoad() {
        super.viewDidLoad()

        if Auth.auth().currentUser == nil
        {
            DispatchQueue.main.async {
                
                let signInController = SignUpController()
                let navgation = UINavigationController(rootViewController: signInController)
                navgation.modalPresentationStyle = .fullScreen
                self.present(navgation, animated: true, completion: nil)
            }
            return
        }
        setupNavController()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    //MARK: ----------- FireMethod ----------------
    func setupNavController()
    {
        view.backgroundColor = .systemBackground
        tabBar.tintColor = .systemGreen
        
        
        viewControllers = [CreatHomeNavC(),CreatsMarketNavC(),CreatvMarketNavC(),CreatProfileNavC()]
    }
    
    
    //MARK: ----------- Creating VIew controllers ----------------
    //Home
    private func CreatHomeNavC() -> UINavigationController {
        let homeController = HomeVController(collectionViewLayout: UICollectionViewFlowLayout())
        let nav = createNavController(viewController: homeController, title: "Deals", image: #imageLiteral(resourceName: "HomeImage"))
        nav.navigationBar.prefersLargeTitles = true
        return nav
    }
    
    
    //sMarket
    private func CreatsMarketNavC() -> UINavigationController {
        let sMarketController = SMarketController(collectionViewLayout: UICollectionViewFlowLayout())
        
        return createNavController(viewController: sMarketController, title: "SuperMarket", image: #imageLiteral(resourceName: "sMarketImage"))
    }
    
    //vMarket
    private func CreatvMarketNavC() -> UINavigationController {
        let vMarketController = VMarketController(collectionViewLayout: UICollectionViewFlowLayout())
        
        return createNavController(viewController: vMarketController, title: "Grocery", image: #imageLiteral(resourceName: "vMarketImage"))
    }
    
    
    //Profile
    private func CreatProfileNavC() -> UINavigationController {
        
        let profileController = ProfileVController(collectionViewLayout: UICollectionViewFlowLayout())
        
        return createNavController(viewController: profileController, title: "Profile", image: #imageLiteral(resourceName: "ProfileImage"))
    }

    
    
    private func createNavController(viewController: UIViewController, title: String, image: UIImage) -> UINavigationController {
        let navController = UINavigationController(rootViewController: viewController)
        navController.navigationBar.prefersLargeTitles = true
        viewController.navigationItem.title = title
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        return navController
        
    }
}
