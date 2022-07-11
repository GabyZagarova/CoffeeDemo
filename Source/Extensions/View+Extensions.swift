//
//  View+Extensions.swift
//  CoffeeDemo iOS
//
//  Created by Gabriela Bakalova on 11.07.22.
//

import SwiftUI

// Create an immediate, looping animation
extension View {
    
    func animateForever(using animation: Animation = .easeInOut(duration: 1), autoreverses: Bool = false, _ action: @escaping () -> Void) -> some View {
        
        let repeated = animation.repeatForever(autoreverses: autoreverses)
        
        return onAppear {
            withAnimation(repeated) {
                action()
            }
        }
    }
    
    func endEditing() {
        
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil, from: nil, for: nil)
    }
}
