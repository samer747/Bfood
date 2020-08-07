//
//  ProfileVController.swift
//  Bfood
//
//  Created by samer on 7/28/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit
import Firebase

private let footerID = "Cellads"
private let headerID = "Cedasdasllads"
private let cellID = "Celldsads"

class ProfileVController: UICollectionViewController ,UICollectionViewDelegateFlowLayout , headerDelegate ,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
    var user: User?
    var uid : String?
    var userEmail : String?
    
    let lablesArr = [
    "My Orders",
    "My WishList",
    "Yours",
    "My Adress Book",
    "Country and Language",
    "Communication Preference",
    "Help Center",
    "Share With friends ya m3rs",
    "Leave feed back ya kosomk",
    "tb rate us 7ata ya 5awl"
    ]
    var imagesArr = [UIImage]()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagesArr.append(#imageLiteral(resourceName: "sMarketImage"))
        imagesArr.append(#imageLiteral(resourceName: "HomeImage"))
        imagesArr.append(#imageLiteral(resourceName: "ProfileImage"))
        imagesArr.append(#imageLiteral(resourceName: "vMarketImage"))
        imagesArr.append(#imageLiteral(resourceName: "sMarketImage"))
        imagesArr.append(#imageLiteral(resourceName: "HomeImage"))
        imagesArr.append(#imageLiteral(resourceName: "ProfileImage"))
        imagesArr.append(#imageLiteral(resourceName: "vMarketImage"))
        imagesArr.append(#imageLiteral(resourceName: "sMarketImage"))
        imagesArr.append(#imageLiteral(resourceName: "HomeImage"))
        
        
        
        collectionView.backgroundColor = .systemBackground
        
        fetchUser()
        
        collectionView!.register(ProfileCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID)
        collectionView.register(ProfileFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerID)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    //MARK: ----------- Methods -------------
    private func fetchUser()
    {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let email = Auth.auth().currentUser?.email else { return }
        self.user = nil
        
        Database.fetchUserWithID(uid: uid) { (user) in
            
            self.user = user
            self.userEmail = email
            self.collectionView.reloadData()
        }
    }
    
    
    
    // MARK: ------------ Cells Setup -------------
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ProfileCell
    
        cell.itemLable.text = lablesArr[indexPath.item]
        cell.itemImage.image = imagesArr[indexPath.item].withTintColor(.label)
    
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 20, left: 0, bottom: 20, right: 0)
    }
    // MARK: ------------ header and header Setup -------------
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        //Header
        case UICollectionView.elementKindSectionHeader:

            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID, for: indexPath) as! ProfileHeader
            header.emailLable.text = userEmail
            header.user = self.user
            header.delegate = self
            return header

        //Footer
        case UICollectionView.elementKindSectionFooter:
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerID, for: indexPath) as! ProfileFooter
            return footerView
        
        default:
            assert(false, "Unexpected element kind")
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }

    //MARK: ------------- imagePicker methods -------------------
    func imagePressed() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.modalPresentationStyle = .fullScreen
        present(imagePicker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectedImage: UIImage?
        if let editedImage = info[.editedImage] as? UIImage {
            selectedImage = editedImage
            picker.dismiss(animated: true, completion: nil)
        } else if let originalImage = info[.originalImage] as? UIImage {
            selectedImage = originalImage
            picker.dismiss(animated: true, completion: nil)
        }
        let imageName = NSUUID().uuidString
        let ref = Storage.storage().reference().child("profile_images").child(imageName)
        guard let uploadData = selectedImage?.jpegData(compressionQuality: 0.5) else { return }
        guard let userID = Auth.auth().currentUser?.uid else { return }
        ref.putData(uploadData, metadata: nil) { (metaData, err) in
            if let err = err {
                print("Erorr in uploading this photo: ", err)
                return
            }
            //succses
            ref.downloadURL { (url, err) in//method btrg3lna el download url
                if let err = err//error
                {   print(err)
                    return
                    
                }
                guard let url = url else {return}
                let dataBaseRef = Database.database().reference().child("Users").child(userID) // da el path ref lel data base
                
                let dataArray:[String: Any] = ["imageURL" : url.absoluteString] // bn7ot kol 7aga fe Dictionary 34an ytrf3o m3 b3d ka 7aga wa7da lel  User
                dataBaseRef.updateChildValues(dataArray)                 // etrfa3 5lassssss
                self.fetchUser()
                self.collectionView.reloadData()
            }
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
