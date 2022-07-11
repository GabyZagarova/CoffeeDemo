//
//  PlaceSearchRequest.swift
//  CoffeeDemo iOS
//
//  Created by Gabriela Bakalova on 5.07.22.
//

import Foundation

struct PlaceSearchRequest: NetworkingRequest {
    
    var name: String {
        "Place search API"
    }
    
    var path: String {
        return "places/search"
    }
        
    var restMethodType: RestMethod {
        return .get
    }

    var requestParameters: Encodable? 
}
