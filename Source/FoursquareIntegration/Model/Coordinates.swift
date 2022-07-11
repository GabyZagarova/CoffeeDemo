//
//  Coordinates.swift
//  CoffeeDemo iOS
//
//  Created by Gabriela Bakalova on 6.07.22.
//

import Foundation
import CoreLocation
import MapKit

struct Coordinates: Codable {
    
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees

    init(with locationCoordinate2D: CLLocationCoordinate2D) {
        self.latitude = locationCoordinate2D.latitude
        self.longitude = locationCoordinate2D.longitude
    }
    
    enum CodingKeys: String, CodingKey {
        case latitude, longitude
    }
}

extension Coordinates {
    
    func toString() -> String {
        return "\(latitude),\(longitude)"
    }
    
    func coordinate() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
