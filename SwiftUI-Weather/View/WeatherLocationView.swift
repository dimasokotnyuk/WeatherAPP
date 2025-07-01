//
//  WeatherLocationView.swift
//  SwiftUI-Weather
//
//  Created by Дмитро Сокотнюк on 05.07.2025.
//

import SwiftUI

struct WeatherLocationView: View {
    var weather: WeatherResponse
    var body: some View {
        VStack {
            Text(weather.location.name)
                .font(.system(size: 32, weight: .medium, design: .default))
                .foregroundColor(.white)
            
            Text(weather.location.date)
                .font(.subheadline)
                .foregroundColor(.white)
            
            Text("  \(Int(weather.current.tempC))°")
                .font(.system(size: 100, weight: .regular))
                .foregroundColor(.white)
            
            Text(weather.current.condition.text)
                .font(.headline)
                .foregroundColor(.white.opacity(0.8))
        }
        .padding(.bottom, 20)
    }
}

#Preview {
  WeatherLocationView(weather: WeatherResponse.sample)
}
