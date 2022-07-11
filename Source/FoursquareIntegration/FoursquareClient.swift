//
//  FoursquareClient.swift
//  CoffeeDemo iOS
//
//  Created by Gabriela Bakalova on 6.07.22.
//

import Foundation

@propertyWrapper
struct FoursquarePlacesLimit {

    private(set) var limitValue: Int = 0
    private let FoursquarePlacesLimit = 50
    
    var wrappedValue: Int {
        get {
            limitValue
        }
        set {
            limitValue = newValue <= FoursquarePlacesLimit ? newValue : FoursquarePlacesLimit
        }
    }

    init(wrappedValue initialValue: Int) {
        self.wrappedValue = initialValue
    }
}

extension FoursquarePlacesLimit: Codable {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.wrappedValue = try container.decode(Int.self)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.wrappedValue)
    }
}


struct FoursquareNetworkConfiguration: NetworkingConfiguration {
    
    var baseURL: URL {
        return URL(string: "https://api.foursquare.com/v3/")!
    }
    
    var apiKey: String {
        return "Foursquare Developer API Key"
    }
}

class FoursquareClient: NetworkingClient {
    
    var networkConfiguration: NetworkingConfiguration {
        return FoursquareNetworkConfiguration()
    }
    
    var session: URLSession {
        return URLSession.shared
    }
}
