//
//  File.swift
//  Bfood
//
//  Created by samer on 8/1/20.
//  Copyright © 2020 samer. All rights reserved.
//

import Foundation


struct Brewerie : Decodable {
    
    let id: Int
    let name: String
    var brewery_type: String?
    var country: String?
    var phone: String?
    var website_url: String?
    var updated_at: String?
    
}

struct AutoBrewerieResult : Decodable {
    
    let id: String
    let name: String
    
    
}

enum SelectedType: String {
    case micro, regional, brewpub, large, planning, bar, contract, proprietor
}

struct Body : Decodable {
   let product_id : Int
}
