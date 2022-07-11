//
//  MapAnnotationView.swift
//  CoffeeDemo iOS
//
//  Created by Gabriela Bakalova on 9.07.22.
//

import SwiftUI
import MapKit

struct MapAnnotationView: View {
    
    var tapAction: () -> Void

    var body: some View {
        ZStack {
            Button(action: {
                print("Tap on image")
                tapAction()
            }, label: {
                Image(systemName: "mappin.and.ellipse")
                    .foregroundColor(.annotation)
                    .font(.title)
            })
            .padding(22)
        }
    }
}

struct MapAnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        MapAnnotationView {
            print("Tap on image")
        }
    }
}
