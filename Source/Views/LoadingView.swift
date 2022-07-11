//
//  LoadingView.swift
//  CoffeeDemo iOS
//
//  Created by Gabriela Bakalova on 7.07.22.
//

import SwiftUI

struct LoadingView: View {
    
    var body: some View {
        ZStack() {
            ProgressView()
                .frame(minWidth: 0, maxWidth: 80, minHeight: 0, maxHeight: 80)
        }
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 10))
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
