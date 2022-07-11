//
//  LocationServicesTracker.swift
//  CoffeeDemo iOS
//
//  Created by Gabriela Bakalova on 5.07.22.
//

import Foundation
import CoreLocation

class LocationServicesTracker: NSObject, ObservableObject {
    
    @Published var authorizationStatusAutorized = false
    @Published private(set) var currentLocation: CLLocation?
    
    fileprivate var locationManager: CLLocationManager?
    
    override init() {
        super.init()
        checkIfLocationServicesIsEnabled()
    }
    
    fileprivate func checkIfLocationServicesIsEnabled() {
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager?.delegate = self
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            locationManager?.startUpdatingLocation()
            checkLocationAtorizationStatus()
        } else {
            debugPrint("Location services are not enabled")
            authorizationStatusAutorized = false
        }
    }
    
    fileprivate func checkLocationAtorizationStatus() {
        
        guard let locationManager = locationManager else {
            return
        }

        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            authorizationStatusAutorized = false
        case .restricted:
            print("Location is restricted.")
            authorizationStatusAutorized = false
        case .denied:
            print("Location is denied.")
            authorizationStatusAutorized = false
        case .authorizedAlways, .authorizedWhenInUse:
            authorizationStatusAutorized = true
        @unknown default:
            break
        }
    }
}

extension LocationServicesTracker: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAtorizationStatus()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            currentLocation = lastLocation
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        debugPrint("Location Manager Fail Error: \(error)")
    }
}
