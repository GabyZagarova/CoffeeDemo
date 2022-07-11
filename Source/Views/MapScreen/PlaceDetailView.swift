//
//  PlaceDetailView.swift
//  CoffeeDemo iOS
//
//  Created by Gabriela Bakalova on 9.07.22.
//

import SwiftUI

struct PlaceShortDetails {
    
    var icon: String?
    var title: String
    var description: String?
}

struct PlaceDetailView: View {

    var item: PlaceShortDetails
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack(alignment: .center, spacing: 8) {
                if let icon = item.icon {
                    Text(icon)
                        .font(.title)
                } else {
                    Image(systemName: "photo.circle.fill")
                        .font(.title)
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(item.title)
                        .font(.title3)
                        .fontWeight(.bold)
                    Text(item.description ?? "")
                        .font(.body)
                        .fontWeight(.light)
                }
                
            }
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                alignment: .topLeading
            )
            .padding(12)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 10))
            .cornerRadius(8)
        }
        .padding(20)
    }
}

struct PlaceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            let exampleItem = PlaceShortDetails(icon: "☕️",
                                                title: "Costa Coffee",
                                                description: "Place for hot and cold coffee")
            
            PlaceDetailView(item: exampleItem)
            
            PlaceDetailView(item: exampleItem)
                .preferredColorScheme(.dark)
        }
    }
}
