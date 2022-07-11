//
//  NetwokringError.swift
//  CoffeeDemo iOS
//
//  Created by Gabriela Bakalova on 5.07.22.
//

import Foundation

typealias ErrorDisplayMessage = (title: String, message: String)

public enum NetworkingError: Error {
    
    case generic
    case noInternetConnection
    case invalidRequestURL
    case invalidResponseData
    
    func displayMessage() -> ErrorDisplayMessage {
        switch self {
        case .generic:
            return (title: "Oops...", message: "Something went wrong.")
        case .noInternetConnection:
            return (title: "No internet connection", message: "Please check your internet connection and try again.")
        case .invalidRequestURL:
            return (title: "Oops...", message: "Something went wrong.")
        case .invalidResponseData:
            return (title: "Oops...", message: "Something went wrong.")
        }
    }
}
