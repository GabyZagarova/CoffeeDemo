//
//  MapView.swift
//  CoffeeDemo iOS
//
//  Created by Gabriela Bakalova on 10.07.22.
//

import SwiftUI
import MapKit
import Combine

struct MapView: View {
    
    @ObservedObject private var mapViewViewModel: MapViewViewModel
    @ObservedObject private var placesViewModel: PlacesViewModel
    
    @Binding private var selectedPlace: Place?
    
    init(withMapViewViewModel mapViewViewModel: MapViewViewModel,
         placesViewModel: PlacesViewModel,
         selectedPlace:  Binding<Place?>?) {
        self.mapViewViewModel = mapViewViewModel
        self.placesViewModel = placesViewModel
        self._selectedPlace = selectedPlace ?? Binding.constant(nil)
    }
    
    var body: some View {
        
        Map(coordinateRegion: $mapViewViewModel.mapRegion,
            interactionModes: .all,
            showsUserLocation: true,
            annotationItems: placesViewModel.places) { place in
            MapAnnotation(coordinate: place.mainGeocode.coordinate()) {
                MapAnnotationView {
                    self.selectedPlace = place
                }
            }
        }
            .onReceive(mapViewViewModel.$mapRegion
                .debounce(for: .milliseconds(500), scheduler: RunLoop.main),
                       perform: { newRegion in

                self.selectedPlace = nil
                placesViewModel.searchLocation = newRegion.center
                placesViewModel.searchRadius = newRegion.radius

                Task {
                    await placesViewModel.searchForPlaces()
                }
            })
            .onTapGesture {
                print("Tap outside")
                self.selectedPlace = nil
                self.endEditing()
            }
            .accentColor(Color(.systemPink))
            .ignoresSafeArea(edges: .bottom)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(withMapViewViewModel: MapViewViewModel(),
                placesViewModel: PlacesViewModel(),
                selectedPlace: Binding.constant(nil))
    }
}
