//
//  BannerView.swift
//  CoffeeDemo iOS
//
//  Created by Gabriela Bakalova on 8.07.22.
//

import SwiftUI

enum BannerViewType {
    case warning
    case error

    var tintColor: Color {
        switch self {
        case .warning:
            return Color.yellow
        case .error:
            return Color.red
        }
    }
}

struct BannerViewData {
    
    var bannerViewType: BannerViewType
    var title:String
    var description:String
}

struct BannerView: View {
    
    @Binding var isVisible: Bool
    @Binding var data: BannerViewData?

    var body: some View {
        ZStack {
            if isVisible {
                VStack {
                    
                    HStack(alignment: .top) {
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text(data?.title ?? "")
                                .font(.title2).fontWeight(.bold)
                                .foregroundColor(.white)
                            Text(data?.description ?? "")
                                .font(.body).fontWeight(.light)
                                .foregroundColor(.white)
                        }
                        
                        Spacer()
                    }
                    .foregroundColor(Color.white)
                    .padding(12)
                    .background(data?.bannerViewType.tintColor)
                    .cornerRadius(8)
                    
                    Spacer()
                }
                .padding(12)
                .animation(.easeInOut, value: 1)
                .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
            }
        }
    }
}

struct BannerView_Previews: PreviewProvider {
    static var previews: some View {
        let exampleBanner = BannerViewData(bannerViewType: .error,
                                           title: "Sorry",
                                           description: "We couldn't find any places nearby.")
        
        BannerView(isVisible: .constant(true), data: .constant(exampleBanner))
    }
}
