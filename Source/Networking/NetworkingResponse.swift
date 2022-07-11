//
//  NetworkingResponse.swift
//  CoffeeDemo iOS
//
//  Created by Gabriela Bakalova on 5.07.22.
//

import Foundation

public enum NetworkingResponse<T> where T: Decodable {
    
    case success(result: T)
    case failure(error: NetworkingError?)
}
