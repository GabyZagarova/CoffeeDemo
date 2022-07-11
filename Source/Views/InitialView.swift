//
//  InitialView.swift
//  CoffeeDemo
//
//  Created by Gabriela Bakalova on 5.07.22.
//

import SwiftUI

struct InitialView: View {
    
    @StateObject private var locationViewModel = LocationServicesTracker()
    
    var body: some View {
        if locationViewModel.authorizationStatusAutorized {
            MapScreenView()
        } else {
            PermissionsView()
        }
    }
}

struct InitialView_Previews: PreviewProvider {
    static var previews: some View {
        InitialView()
    }
}
