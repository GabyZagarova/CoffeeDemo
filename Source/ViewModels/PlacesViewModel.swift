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
            .map { PlaceCategory(id: Int64($0))}
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
            let response = try await FoursquareClient().performRequest(responseType: PlaceSearchResult.self, request: placeSearchRequest)
           
            switch response {
            case .success(let result):
                DispatchQueue.main.async {
                    self.isSearching = false
                    self.places = result.places
                    self.handleError(error: nil, message: result.message)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.isSearching = false
                    self.handleError(error: error, message: nil)
                }
            }
            
        } catch let error {
            self.isSearching = false
            handleError(error: error, message: nil)
        }
    }
    
    func handleError(error: Error?, message: String?) {
        guard (error != nil) || (message != nil) else {
            self.shouldShowBanner = false

            return
        }

        self.shouldShowBanner = true
        let bannerData = BannerViewData(bannerViewType: .error, title: "Sorry", description: "We couldn't find any places nearby.")
        self.bannerData = bannerData
    }
}
