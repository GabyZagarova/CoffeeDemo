//
//  MKCoordinateRegion+Extensions.swift
//  CoffeeDemo iOS
//
//  Created by Gabriela Bakalova on 10.07.22.
//

import MapKit

extension MKCoordinateRegion {
    
    public var radius: CLLocationDistance {
        let loc1 = CLLocation(latitude: center.latitude - span.latitudeDelta * 0.5, longitude: center.longitude)
        let loc2 = CLLocation(latitude: center.latitude + span.latitudeDelta * 0.5, longitude: center.longitude)
        let loc3 = CLLocation(latitude: center.latitude, longitude: center.longitude - span.longitudeDelta * 0.5)
        let loc4 = CLLocation(latitude: center.latitude, longitude: center.longitude + span.longitudeDelta * 0.5)
    
        let metersInLatitude = loc1.distance(from: loc2)
        let metersInLongitude = loc3.distance(from: loc4)
        let radius = max(metersInLatitude, metersInLongitude) / 2.0
        
        return radius
    }
}
