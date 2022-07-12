//
//  NetwokringError.swift
//  CoffeeDemo iOS
//
//  Created by Gabriela Bakalova on 5.07.22.
//

import Foundation

typealias ErrorDisplayMessage = (title: String, text: String)

public enum NetworkingError: Error {
    
    case generic
    case noInternetConnection
    case invalidRequestURL
    case invalidResponseData
    
    func displayMessage() -> ErrorDisplayMessage {
        switch self {
        case .generic:
            return (title: "Oops...", text: "Something went wrong.")
        case .noInternetConnection:
            return (title: "Oops...", text: "The Internet connection appears to be offline.")
        case .invalidRequestURL:
            return (title: "Oops...", text: "Something went wrong.")
        case .invalidResponseData:
            return (title: "Oops...", text: "We couldn't find any places nearby.")
        }
    }
}

extension Error {
    
    func toNetworkingError() -> NetworkingError {
        let errorCode = (self as NSError).code

        if errorCode == URLError.notConnectedToInternet.rawValue {
            return .noInternetConnection
        } else {
            return .generic
        }
        // More Error types heere
    }
}

extension NSError {
    
    func toNetworkingError() -> NetworkingError {
        if self.code == URLError.notConnectedToInternet.rawValue {
            return .noInternetConnection
        } else {
            return .generic
        }
        // More Error types heere
    }
}
