//
//  PlaceSearchRequestTest.swift
//  CoffeeDemoTests
//
//  Created by Gabriela Bakalova on 12.07.22.
//

import XCTest
import Foundation
@testable import CoffeeDemo
import CoreLocation

class PlaceSearchRequestTest: XCTestCase {

    @MainActor func testFoursquarePlaceSearchRequestParameters() {
    
        let testLocation = CLLocationCoordinate2D(latitude: 51.50998, longitude: -0.1337000000000174)
        let mapViewViewModel = MapViewViewModel()
        mapViewViewModel.mapRadius =  MapDetails.defaultRadiusValue
        mapViewViewModel.mapRegionCenter = testLocation
        mapViewViewModel.updateMapRangion()
                
        let searchKey = "costa"
        let locationCoordinates = Coordinates(with: testLocation)
        let searchRadius = mapViewViewModel.mapRegion.radius
        let coffeeCategories = [13032, 13033, 13034].map { PlaceCategory(id: Int64($0), name: "")}
        let limit = 100
        
        let requestParameters = PlaceSearchRequestParameters(searchKey: searchKey,
                                                             initialCoordinates: locationCoordinates,
                                                             radius: Int(searchRadius),
                                                             categories: coffeeCategories,
                                                             limit: limit)
        let placeSearchRequest = PlaceSearchRequest(parameters: requestParameters)
        let urlRequest = FoursquareClient().buildURLRequest(request: placeSearchRequest)
        let generatedURLString = urlRequest.url!.absoluteString
            
        let expectedURLString = "https://api.foursquare.com/v3/places/search?query=costa&limit=50&radius=2500&ll=51.50998%2C-0.1337000000000174&categories=13032%2C13033%2C13034"
        
        let generatedURLComponents = URLComponents(string:generatedURLString)!
        let expectedURLComponents = URLComponents(string:expectedURLString)!

        XCTAssertEqual(generatedURLComponents.host, expectedURLComponents.host)
        XCTAssertEqual(generatedURLComponents.path, expectedURLComponents.path)
        
        if let expectedQueryItems = expectedURLComponents.queryItems {
            for queryItem in expectedQueryItems {
                if let generatedQueryItems = generatedURLComponents.queryItems {
                    
                    for gQueryItem in generatedQueryItems {
                        if queryItem.name == gQueryItem.name {
                            XCTAssertEqual(queryItem.value, gQueryItem.value)
                        }
                    }
                }
            }
        }
    }
}
