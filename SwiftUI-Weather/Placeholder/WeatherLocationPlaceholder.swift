//
//  WeatherLocationPlaceholder.swift
//  SwiftUI-Weather
//
//  Created by Дмитро Сокотнюк on 05.07.2025.
//

import SwiftUI

struct WeatherLocationPlaceholder: View {
    var body: some View {
        VStack {
            Text("Kyiv")
                .font(.system(size: 32, weight: .medium, design: .default))
                .foregroundColor(.white)
                .redacted(reason: .placeholder)
                .shimmering()
            
            Text("Friday, 4 July")
                .font(.subheadline)
                .foregroundColor(.white)
                .redacted(reason: .placeholder)
                .shimmering()
            
            Text("  25°")
                .font(.system(size: 100, weight: .regular))
                .foregroundColor(.white)
                .redacted(reason: .placeholder)
                .shimmering()
            
            Text("Patchy rain nearby")
                .font(.headline)
                .foregroundColor(.white.opacity(0.8))
                .redacted(reason: .placeholder)
                .shimmering()
        }
        .padding(.bottom, 20)
    }
}

#Preview {
    WeatherLocationPlaceholder()
}
