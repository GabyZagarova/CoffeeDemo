//
//  Place.swift
//  CoffeeDemo iOS
//
//  Created by Gabriela Bakalova on 6.07.22.
//

import Foundation

struct Place: Identifiable {
    
    let id = UUID()
    
    /// A unique identifier for a FSQ Place (formerly known as Venue ID).
    var fsqID: String
    
    /// The best known name for the FSQ Place.
    var name: String
    
    /// An array, possibly empty, of categories that describe the FSQ Place. Included subfields: id (Category ID), name (Category Label), and icon (Category's Icon).
    var categories: [PlaceCategory]

    /// Main place coordinates
    var mainGeocode: Coordinates
}

extension Place: Codable {
    
    enum CodingKeys: String, CodingKey {
        case fsqID = "fsq_id"
        case name
        case categories
        case geocodes
    }
    
    /// Nested JSON object lits
    enum GeocodeCodingKeys: String, CodingKey {
        case mainGeocode = "main"
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        fsqID = try container.decode(String.self, forKey: .fsqID)
        name = try container.decode(String.self, forKey: .name)
        categories = try container.decode([PlaceCategory].self, forKey: .categories)
        
        let geocodesContainer = try container.nestedContainer(keyedBy: GeocodeCodingKeys.self, forKey: .geocodes)
        mainGeocode = try geocodesContainer.decode(Coordinates.self, forKey: .mainGeocode)
    }
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(fsqID, forKey: .fsqID)
        try container.encode(name, forKey: .name)
        try container.encode(categories, forKey: .categories)
        
        var nestedContainer = container.nestedContainer(keyedBy: GeocodeCodingKeys.self, forKey: .geocodes)
        try nestedContainer.encode(mainGeocode, forKey: .mainGeocode)
    }
}

extension Place: Equatable {
    
    static func == (lhs: Place, rhs: Place) -> Bool {
        return lhs.fsqID == rhs.fsqID &&
        lhs.name == rhs.name &&
        lhs.mainGeocode.latitude == rhs.mainGeocode.latitude &&
        lhs.mainGeocode.longitude == rhs.mainGeocode.longitude &&
        lhs.categories == rhs.categories
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
