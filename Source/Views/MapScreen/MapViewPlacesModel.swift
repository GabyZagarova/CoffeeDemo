//
//  PlacesViewModel.swift
//  CoffeeDemo iOS
//
//  Created by Gabriela Bakalova on 6.07.22.
//

import Foundation

class MapViewPlacesModel: ObservableObject {

    @Published var places: [Place] = []
    @Published var radius = 300.0

    @Published var alertMessage: ErrorDisplayMessage?
    
    func loadPlaces() async {

        let requestParameters = PlaceSearchRequestParametrs(searchKey: "",
                                                            initialCoordinates: LondonCoordinates,
                                                            radius: Int(radius),
                                                            categories: [PlaceCategory(id: 13034, name: "Coffee")],
                                                            limit: 10)
        let placeSearchRequest = PlaceSearchRequest(parameters: requestParameters)
        do {
            let response = try await FoursquareClient().performRequest(responseType: PlaceSearchResult.self, request: placeSearchRequest)
           
            switch response {
            case .success(let result):
                DispatchQueue.main.async {
                    self.places = result.places
                }
                print("Place Search API results count: \(result.places.count)")
            case .failure(let error):
                print("Place Search API error \(String(describing: error?.localizedDescription))")
            }
            
        } catch let error {
            print("Place Search API error \(error.localizedDescription)")
        }
    }
}
