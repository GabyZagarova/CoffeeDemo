//
//  PermissionsView.swift
//  CoffeeDemo iOS
//
//  Created by Gabriela Bakalova on 7.07.22.
//

import SwiftUI

struct PermissionsView: View {
    
    @State private var scale = 1.0

    var body: some View {
        ZStack{
            
            Image("background")
                .blur(radius: 5)
            
            VStack(alignment: .center) {
                Spacer()
                
                VStack(alignment: .center, spacing: 16) {
                    Image(systemName: "location.slash.fill")
                        .font(.largeTitle)
                        .scaleEffect(scale)
                            .animateForever(autoreverses: true) {
                                scale = 1.5
                            }
                    
                    Text("Allow your location")
                        .font(.title2).fontWeight(.bold)
                        .multilineTextAlignment(.center)
                    
                    Text("We will need your location your location to give you better experiance. Please go to Settings on your device and allow access to your location.")
                        .font(.body).fontWeight(.light)
                        .multilineTextAlignment(.center)
                }
                .foregroundColor(.black)
                .padding(40)
                
                Spacer()
                
                Button("Go to settings") {
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                }
                .font(.headline)
                
                Spacer()
            }
        }
    }
}

struct PermissionsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PermissionsView()
            PermissionsView()
                .preferredColorScheme(.dark)
        }
    }
}
