//
//  PlaceModelTest.swift
//  CoffeeDemoTests
//
//  Created by Gabriela Bakalova on 12.07.22.
//

import XCTest
import CoreLocation
import Foundation
@testable import CoffeeDemo

class PlaceModelTest: XCTestCase {

    var place: Place?
    var noCategoryPlace: Place?

    override func setUp() {
        let category13002 = PlaceCategory(id: 13002,
                                          name: "Bakery")
        let coordinates = Coordinates(with: CLLocationCoordinate2D(latitude: 51.509652, longitude: -0.135689))
        self.place = Place(fsqID: "5113babbd63e8bb673ce4b25",
                           name: "Carpo Piccadilly",
                           categories: [category13002],
                           mainGeocode: coordinates)
        
        self.noCategoryPlace = Place(fsqID: "5113babbd63e8bb673ce4b25",
                                     name: "Carpo Piccadilly",
                                     categories: [],
                                     mainGeocode: coordinates)
    }

    func testPlaceCoding() throws {
        let decoder = JSONDecoder()
        let encoder = JSONEncoder()
        
        let data = try encoder.encode(place)
        let decodedPlace = try decoder.decode(Place.self, from: data)

        // Asserting that the two instances are equal:
        XCTAssertEqual(place, decodedPlace)
    }

    
    func testNoCategoryPlaceCoding() throws {
        let decoder = JSONDecoder()
        let encoder = JSONEncoder()
        
        let data = try encoder.encode(noCategoryPlace)
        let decodedPlace = try decoder.decode(Place.self, from: data)

        // Asserting that the two instances are equal:
        XCTAssertEqual(noCategoryPlace, decodedPlace)
    }

}
