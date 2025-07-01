//
//  WeatherDaysPlaceholder.swift
//  SwiftUI-Weather
//
//  Created by Дмитро Сокотнюк on 05.07.2025.
//

import SwiftUI

struct WeatherDaysPlaceholder: View {
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 20) {
                ForEach(0..<24) { index in
                    VStack {
                        Text(index == 0 ? "Current" : "12")
                            .font(.system(size: 16, weight: .medium, design: .default))
                            .foregroundStyle(.white)
                            .redacted(reason: .placeholder)
                            .shimmering()
                        
                        Image(.sun)
                            .symbolRenderingMode(.multicolor)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                            .redacted(reason: .placeholder)
                            .shimmering()
                        
                        Text("24°")
                            .font(.system(size: 20, weight: .medium, design: .default))
                            .foregroundColor(.white)
                            .redacted(reason: .placeholder)
                            .shimmering()
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 6)
                }
            }
        }
        .fixedSize(horizontal: false, vertical: true)
        //        .padding()
        .background(.ultraThinMaterial.opacity(0.4))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .frame(maxWidth: UIScreen.main.bounds.width * 0.9) // 90% ширини екрану
    }
}

#Preview {
    WeatherDaysPlaceholder()
}
