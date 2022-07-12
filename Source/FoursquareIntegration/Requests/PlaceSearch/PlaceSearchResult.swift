//
//  PlaceSearchResult.swift
//  CoffeeDemo iOS
//
//  Created by Gabriela Bakalova on 6.07.22.
//

import Foundation
import SwiftUI

struct PlaceSearchResult {
    
    var places: [Place]
    var message: String?
}

extension PlaceSearchResult: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case places = "results"
        case message  = "message"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        message = try container.decodeIfPresent(String.self, forKey: .message)
        places = [Place]()
        
        if var nestedContainer = try? container.nestedUnkeyedContainer(forKey: .places) {
            while !nestedContainer.isAtEnd {
                if let value = try? nestedContainer.decode(Place.self) {
                    places.append(value)
                } else {
                    try nestedContainer.skip()
                }
            }
        } else {
            return
        }
    }
}
