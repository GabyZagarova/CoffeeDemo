//
//  PlacesViewModelTests.swift
//  CoffeeDemo iOS Tests
//
//  Created by Gabriela Bakalova on 11.07.22.
//

import XCTest
import CoreLocation
import Foundation
@testable import CoffeeDemo

class PlacesViewModelTests: XCTestCase {

    var viewModel: PlacesViewModel!
    
    let places: [Place] = {
        let category13002 = PlaceCategory(id: 13002,
                                          name: "Bakery")
        let coordinates = Coordinates(with: CLLocationCoordinate2D(latitude: 51.509652, longitude: -0.135689))
        let place = Place(fsqID: "5113babbd63e8bb673ce4b25",
                          name: "Carpo Piccadilly",
                          categories: [category13002],
                          mainGeocode: coordinates)
        return [place]
    }()
    
    override func setUp() {
        viewModel = .init()
        viewModel.searchRadius = 300
        viewModel.searchTerm = "Costa"
        viewModel.searchLocation = CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12)
    }
    
    func testViewModelInitialState() {
        XCTAssertEqual(viewModel.isSearching, false)
        XCTAssertEqual(viewModel.shouldShowBanner, false)
        XCTAssertNil(viewModel.bannerData)
        XCTAssertEqual(viewModel.places.isEmpty, true)
    }
    
    func testHandleMissingAPIKey() {
        XCTAssertEqual(viewModel.shouldShowBanner, false)
        XCTAssertNil(viewModel.bannerData)
                
        let response = NetworkingResponse<PlaceSearchResult>.failure(error: NetworkingError.generic)
        viewModel.handleSerachPlacesResponse(serviceResponse: response)
        
        XCTAssertEqual(viewModel.isSearching, false)
        XCTAssertEqual(viewModel.shouldShowBanner, true)
        XCTAssertNotNil(viewModel.bannerData)
        XCTAssertEqual(viewModel.bannerData!.bannerViewType, .error)
        XCTAssertEqual(viewModel.bannerData!.title, "Oops...")
        XCTAssertEqual(viewModel.bannerData!.description, "Something went wrong.")
        XCTAssertEqual(viewModel.places.isEmpty, true)
    }
    
    func testHandleGenericError() {
        XCTAssertEqual(viewModel.shouldShowBanner, false)
        XCTAssertNil(viewModel.bannerData)
        
        let noInternetError = NSError(domain: "Domain", code: URLError.notConnectedToInternet.rawValue)
        let response = NetworkingResponse<PlaceSearchResult>.failure(error: noInternetError.toNetworkingError())
        viewModel.handleSerachPlacesResponse(serviceResponse: response)
        
        XCTAssertEqual(viewModel.isSearching, false)
        XCTAssertEqual(viewModel.shouldShowBanner, true)
        XCTAssertNotNil(viewModel.bannerData)
        XCTAssertEqual(viewModel.bannerData?.bannerViewType, .error)
        XCTAssertEqual(viewModel.bannerData?.title, "Oops...")
        XCTAssertEqual(viewModel.bannerData?.description, "The Internet connection appears to be offline.")
        XCTAssertEqual(viewModel.places.isEmpty, true)
    }
    
    func testHandleMessage() {
        XCTAssertEqual(viewModel.shouldShowBanner, false)
        XCTAssertNil(viewModel.bannerData)

        let placesResult = PlaceSearchResult(places: [], message: "Invalid request token.")
        let response = NetworkingResponse.success(result: placesResult)
        viewModel.handleSerachPlacesResponse(serviceResponse: response)
        
        XCTAssertEqual(viewModel.places.isEmpty, true)

        XCTAssertEqual(viewModel.isSearching, false)
        XCTAssertEqual(viewModel.shouldShowBanner, true)
        XCTAssertNotNil(viewModel.bannerData)
        XCTAssertEqual(viewModel.bannerData?.bannerViewType, .error)
        XCTAssertEqual(viewModel.bannerData?.title, "Oops...")
        XCTAssertEqual(viewModel.bannerData?.description, "Something went wrong.")
    }
    
    func testHandlePlaces() {
        XCTAssertEqual(viewModel.shouldShowBanner, false)
        XCTAssertNil(viewModel.bannerData)

        let placesResult = PlaceSearchResult(places: places, message: nil)
        let response = NetworkingResponse.success(result: placesResult)
        viewModel.handleSerachPlacesResponse(serviceResponse: response)
        
        XCTAssertEqual(viewModel.isSearching, false)
        XCTAssertEqual(viewModel.shouldShowBanner, false)
        XCTAssertNil(viewModel.bannerData)
        XCTAssertEqual(viewModel.places.count, 1)
    }

}
