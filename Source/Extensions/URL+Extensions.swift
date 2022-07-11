//
//  URL+Extensions.swift
//  CoffeeDemo iOS
//
//  Created by Gabriela Bakalova on 6.07.22.
//

import Foundation

extension URL {
    
    func addQueryParams(params: [String: Any]?) -> URL {
        
        guard let params = params else { return self }
        
        var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: false)!
        var queryItems = [URLQueryItem]()
        for (key, value) in params {
            let itemValue = String(describing: value)
            let queryItem = URLQueryItem(name: key, value: itemValue)
            queryItems.append(queryItem)
        }
        urlComponents.queryItems = queryItems
        
        return urlComponents.url!
    }
    
    func escapedURL() -> URL {
        let str = self.absoluteString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)?
            .replacingOccurrences(of: ",", with: "%2C") ?? ""
        return URL(string: str)!
    }
}
