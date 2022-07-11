//
//  MapScreenView.swift
//  CoffeeDemo iOS
//
//  Created by Gabriela Bakalova on 5.07.22.
//

import SwiftUI
import MapKit
import UIKit

struct MapScreenView: View {
        
    @StateObject private var locationTracker = LocationServicesTracker()
    @StateObject private var mapViewViewModel: MapViewViewModel = MapViewViewModel()
    @StateObject private var placesViewModel: PlacesViewModel = PlacesViewModel()
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {

                MapView(withMapViewViewModel: mapViewViewModel,
                        placesViewModel: placesViewModel,
                        selectedPlace: $mapViewViewModel.selectedPlace)

                if let selectedPlace = mapViewViewModel.selectedPlace {
                    
                    PlaceDetailView(item: selectedPlace.placeShortDetails())
                    
                } else {
                    
                    HStack {
                        RadiusSliderView(radius: $mapViewViewModel.mapRadius)

                        Spacer()
                        
                        Button(action: {
                            centerMap()
                        }) {
                            Image(systemName: "location.circle")
                                .font(.largeTitle)
                                .padding(.trailing, 20)
                        }
                    }
                }
     
                BannerView(isVisible: $placesViewModel.shouldShowBanner,
                           data: $placesViewModel.bannerData)
                    .animation(.spring(), value: placesViewModel.shouldShowBanner)

            }
            .searchable(text: $placesViewModel.searchTerm, prompt: "Search for place")
            .onReceive(placesViewModel.$searchTerm) { searchTerm in
                guard !searchTerm.isEmpty else { return }

                Task {
                    await placesViewModel.searchForPlaces()
                }
            }
            .navigationTitle("Nearby places")
            .overlay {
                if placesViewModel.isSearching {
                    LoadingView()
                }
            }
        }
        .navigationViewStyle(.stack)
        .ignoresSafeArea()
        .task {
            centerMap()
        }
    }
    
    func centerMap() {
        guard let currentLocation = locationTracker.currentLocation else { return }
        placesViewModel.searchLocation = currentLocation.coordinate
        placesViewModel.searchRadius = MapDetails.defaultRadiusValue

        mapViewViewModel.mapRadius = MapDetails.defaultRadiusValue
        mapViewViewModel.mapRegionCenter = currentLocation.coordinate
        mapViewViewModel.updateMapRangion()
    }
}

struct MapScreenView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MapScreenView()
            MapScreenView()
                .preferredColorScheme(.dark)
        }
    }
}
