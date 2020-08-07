//
//  Service.swift
//  Bfood
//
//  Created by samer on 7/29/20.
//  Copyright © 2020 samer. All rights reserved.
//

import Foundation
import Firebase

extension Database{
    
    static func fetchUserWithID(uid: String, completion: @escaping(User) -> () ){
        Database.database().reference().child("Users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            guard  let dic = snapshot.value as? [String: Any] else { return }
            let user = User(uid: uid, dic: dic)
            completion(user)
            
        }) { (err) in
            print("Error in fetching user data :",err)
        }
    }
    
    static func fetchNumOfProductsInCart(uid: String, completion: @escaping(Int) -> () ){
        Database.database().reference().child("Cart").child(uid).observeSingleEvent(of: .value) { (snapshot) in
            guard let value = snapshot.value as? [String: Any] else { return }
            let x = value.count
            completion(x)
        }
    }
}

class Services {
    //da ely hnady beh el  methods el public kolha
    static let shared = Services()
    
    //FetchAutoComplete
    func fetchAutoComplete(query: String,completion : @escaping ([AutoBrewerieResult]?,Error?) -> Void){
        
        URLSession.shared.dataTask(with: URL(string: "https://api.openbrewerydb.org/breweries/autocomplete?query=\(query)")!) { (data, res, err) in
            if let err = err {
                ///Faild
                completion(nil,err)
                return
            }
            ///Success
            do{
                let object =  try JSONDecoder().decode([AutoBrewerieResult].self, from: data!)
                completion(object,nil)
            }catch{
                print(error)
                completion(nil,error)
                return
            }
        }.resume()
    }
    
    //FetchByID
    func fetchBrewerieByID(id: String,completion : @escaping (Brewerie?,Error?) -> Void){
        Services.shared.fetchGenericJSONData(Url: "https://api.openbrewerydb.org/breweries/\(id)", completion: completion)
    }
    
    //Fetching Catgories
    func fetchRegional(completion : @escaping ([Brewerie]?,Error?) -> Void){
        Services.shared.fetchGenericJSONData(Url: "https://api.openbrewerydb.org/breweries?by_type=regional", completion: completion)
    }
    
    func fetchMicro(completion : @escaping ([Brewerie]?,Error?) -> Void){
        fetchGenericJSONData(Url: "https://api.openbrewerydb.org/breweries?by_type=micro", completion: completion)
    }
    
    func fetchLarge(completion : @escaping ([Brewerie]?,Error?) -> Void){
        fetchGenericJSONData(Url: "https://api.openbrewerydb.org/breweries?by_type=large", completion: completion)
        
    }
    
    //MARK: - Func gamda fsh55555555 -
    func fetchGenericJSONData<T: Decodable>(Url: String ,completion : @escaping (T?,Error?) -> ()) {
        guard let stringUrl = URL(string: Url) else { return }
        URLSession.shared.dataTask(with: stringUrl) { (data, res, err) in
            if let err = err {
                ///Faild
                completion(nil,err)
                return
            }
            ///Success
            do{
               let object =  try JSONDecoder().decode(T.self, from: data!)
                completion(object,nil)
            }catch{
                completion(nil,err)
                return
            }
        }.resume()
    }
}
