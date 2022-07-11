//
//  PlaceCategory.swift
//  CoffeeDemo iOS
//
//  Created by Gabriela Bakalova on 6.07.22.
//

import Foundation

struct PlaceCategory: Codable {
    
    var id: Int64
    var name: String?
}

extension PlaceCategory {
    
    func categoryIcon() -> String {
        
        switch self.id {
        case 10000...11000:
            return "🎨"
        case 11001...11999:
            return "💰"
        case 12000...12999:
            return "👬"
        case 13000...13999:
            return "☕️"
        case 14000...14999:
            return "🎪"
        case 15000...15999:
            return "🏥"
        case 16000...16999:
            return "🏛"
        case 17000...17999:
            return "🏪"
        case 18000...18999:
            return "⚽️"
        case 19000...19999:
            return "🚎"
        default:
            return ""
        }
    }
    
    func categoryTitle() -> String {
        
        switch self.id {
        case 10000...11000:
            return "Arts and Entertainment"
        case 11001...11999:
            return "Business and Professional Services"
        case 12000...12999:
            return "Community and Government"
        case 13000...13999:
            return "Dining and Drinking"
        case 14000...14999:
            return "Event"
        case 15000...15999:
            return "Health and Medicine"
        case 16000...16999:
            return "Landmarks and Outdoors"
        case 17000...17999:
            return "Retail"
        case 18000...18999:
            return "Sports and Recreation"
        case 19000...19999:
            return "Travel and Transportation"
        default:
            return ""
        }
    }
}
