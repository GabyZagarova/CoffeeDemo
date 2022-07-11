//
//  RadiusSliderView.swift
//  CoffeeDemo iOS
//
//  Created by Gabriela Bakalova on 7.07.22.
//

import SwiftUI
import Combine

struct RadiusSliderView: View {
    
    @Binding var radius: Double

    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text(String(format: "Radius: %.f", radius))
                    .bold()
            }
        }
        .padding(10)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 10))
        .padding(20)
    }
}

struct RadiusSliderView_Previews: PreviewProvider {
    
    static var previews: some View {
        RadiusSliderView(radius: .constant(MapDetails.defaultRadiusValue))
    }
}
