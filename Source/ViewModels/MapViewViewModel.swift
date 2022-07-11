//
//  MapCoordinatorViewModel.swift
//  CoffeeDemo iOS
//
//  Created by Gabriela Bakalova on 6.07.22.
//
import MapKit
import CoreLocation
import Combine

struct MapDetails {
    static let defaultCenter = CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12) //a.k.a London
    static let defaultRadiusValue = 5000.0
    static let minRadiusValue = 100.0
    static let maxRadiusValue = 10000.0
}

@MainActor class MapViewViewModel: ObservableObject {
    
    @Published var mapRegion: MKCoordinateRegion = {
        return MKCoordinateRegion(center: MapDetails.defaultCenter,
                                  latitudinalMeters: MapDetails.defaultRadiusValue,
                                  longitudinalMeters: MapDetails.defaultRadiusValue)
    }() {
        didSet {
            mapRadius = mapRegion.radius
            mapRegionCenter = mapRegion.center
        }
    }
    
    @Published var selectedPlace: Place?
    @Published var mapRadius: Double = MapDetails.defaultRadiusValue
    @Published var mapRegionCenter: CLLocationCoordinate2D = MapDetails.defaultCenter
    
    func updateMapRangion() {
        
        self.mapRegion = MKCoordinateRegion(center: mapRegionCenter,
                                            latitudinalMeters: mapRadius,
                                            longitudinalMeters: mapRadius)
    }
}
