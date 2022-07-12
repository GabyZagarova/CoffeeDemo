//
//  NetworkingRequest.swift
//  CoffeeDemo iOS
//
//  Created by Gabriela Bakalova on 5.07.22.
//

import Foundation
    
protocol NetworkingRequest {
    
    var name: String { get }
    var path: String { get }
    var restMethodType: RestMethod { get }
    var requestParameters: Encodable? { get set }

    init()
}

extension NetworkingRequest {
    
    init (parameters: Encodable?) {
        self.init()
        self.requestParameters = parameters
    }
}
