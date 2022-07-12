//
//  PlacesViewModel.swift
//  CoffeeDemo iOS
//
//  Created by Gabriela Bakalova on 9.07.22.
//

import Foundation
import MapKit
import Combine

class PlacesViewModel: ObservableObject {
    
    @Published var searchTerm: String = ""
    @Published var searchLocation: CLLocationCoordinate2D = MapDetails.defaultCenter
    @Published var searchRadius: Double = MapDetails.defaultRadiusValue
    
    @Published private(set) var isSearching = false
    @Published var shouldShowBanner = false
    @Published var bannerData: BannerViewData?

    @Published private(set) var places: [Place] = []

    fileprivate let coffeeCategories = {
        return [13032, 13033, 13034, 13015, 13036, 11126, 13063, 17063, 11125, 12021]
            .map { PlaceCategory(id: Int64($0), name: "")}
    }()
        
    func searchForPlaces() async {
        let locationCoordinates = Coordinates(with: searchLocation)
        let requestParameters = PlaceSearchRequestParameters(searchKey: searchTerm,
                                                             initialCoordinates: locationCoordinates,
                                                             radius: Int(searchRadius),
                                                             categories: coffeeCategories,
                                                             limit: 100)
        let placeSearchRequest = PlaceSearchRequest(parameters: requestParameters)
        isSearching = true

        do {
            let serviceResponse = try await FoursquareClient().performRequest(responseType: PlaceSearchResult.self, request: placeSearchRequest)
            self.isSearching = false
            self.handleSerachPlacesResponse(serviceResponse: serviceResponse)
            
        } catch let error {
            self.isSearching = false
            handleNetworkingError(error: error.toNetworkingError())
        }
    }
    
    func handleSerachPlacesResponse(serviceResponse: NetworkingResponse<PlaceSearchResult>) {
        switch serviceResponse {
        case .success(let result):
            self.places = result.places
            if (result.message != nil) {
                // For now handle api error message as generic error type
                self.handleNetworkingError(error: NetworkingError.generic)
            }
        case .failure(let error):
            self.handleNetworkingError(error: error)
        }
    }
    
    func handleNetworkingError(error: NetworkingError?) {
        guard let error = error else {
            self.shouldShowBanner = false
            return
        }
        
        self.shouldShowBanner = true
        let errorDisplayMessage = error.displayMessage()
        self.bannerData = BannerViewData(bannerViewType: .error,
                                         title: errorDisplayMessage.title,
                                         description: errorDisplayMessage.text)
    }
}
