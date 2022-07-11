//
//  NetworkingConfiguration.swift
//  CoffeeDemo iOS
//
//  Created by Gabriela Bakalova on 6.07.22.
//

import Foundation

protocol NetworkingConfiguration {
    
    var baseURL: URL { get }
    var apiKey: String { get }
}
