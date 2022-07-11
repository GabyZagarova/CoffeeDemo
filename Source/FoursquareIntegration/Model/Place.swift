//
//  Place.swift
//  CoffeeDemo iOS
//
//  Created by Gabriela Bakalova on 6.07.22.
//

import Foundation

struct Place: Decodable, Identifiable {
    
    let id = UUID()
    
    /// A unique identifier for a FSQ Place (formerly known as Venue ID).
    var fsqID: String
    
    /// The best known name for the FSQ Place.
    var name: String
    
    /// An array, possibly empty, of categories that describe the FSQ Place. Included subfields: id (Category ID), name (Category Label), and icon (Category's Icon).
    var categories: [PlaceCategory]

    /// Main place coordinates
    var mainGeocode: Coordinates
    
    /// Nested JSON object lits
    enum GeocodeCodingKeys: String, CodingKey {
        case mainGeocode = "main"
    }
    
    enum CodingKeys: String, CodingKey {
        case fsqID = "fsq_id"
        case name
        case categories
        case location
        case geocodes
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        fsqID = try container.decode(String.self, forKey: .fsqID)
        name = try container.decode(String.self, forKey: .name)
        categories = try container.decode([PlaceCategory].self, forKey: .categories)
        
        let geocodesContainer = try container.nestedContainer(keyedBy: GeocodeCodingKeys.self, forKey: .geocodes)
        mainGeocode = try geocodesContainer.decode(Coordinates.self, forKey: .mainGeocode)
    }
}

extension Place {
    
    func placeShortDetails() -> PlaceShortDetails {
        let placeShortDetails = PlaceShortDetails(icon: self.categories.first?.categoryIcon(),
                                                  title: self.name,
                                                  description: self.categories.first?.name)
        return placeShortDetails
    }
}
