//
//  PlaceSearchRequestParameters.swift
//  CoffeeDemo iOS
//
//  Created by Gabriela Bakalova on 6.07.22.
//

import Foundation
import MapKit

struct PlaceSearchRequestParameters: Codable {

    /// A string to be matched against all content for this place, including but not limited to venue name, category, taste, and tips.
    var searchKey: String?
    
    /// The latitude/longitude around which to retrieve place information. This must be specified as latitude,longitude (e.g., ll=41.8781,-87.6298). Expected type - String
    var initialCoordinates: Coordinates //String
    
    /// Defines the distance (in meters) within which to bias place results. The maximum allowed radius is 100,000 meters. Radius is used with ll or ip biased geolocation only.
    var radius: Int

    ///Filters the response and returns FSQ Places matching the specified categories. Supports multiple Category IDs, separated by commas. Expected type - String
    var categories: [PlaceCategory]?
    
    /// The number of results to return, up to 50. Defaults to 10.
    @FoursquarePlacesLimit
    var limit: Int

    enum CodingKeys: String, CodingKey {
        case searchKey = "query"
        case initialCoordinates = "ll"
        case radius = "radius"
        case categories = "categories"
        case limit = "limit"
    }
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(searchKey, forKey: .searchKey)
        
        let initialCoordinatesString = initialCoordinates.toString()
        try container.encode(initialCoordinatesString, forKey: .initialCoordinates)
        
        try container.encode(radius, forKey: .radius)

        if let categories = categories {
            let categoriesStrings = categories.map{ String($0.id) }
            let categoriesSingleString = categoriesStrings.joined(separator: ",")
            try container.encode(categoriesSingleString, forKey: .categories)
        }
        
        try container.encode(limit, forKey: .limit)
    }
}
