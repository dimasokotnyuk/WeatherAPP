//
//  WeatherDaysView.swift
//  SwiftUI-Weather
//
//  Created by Дмитро Сокотнюк on 05.07.2025.
//

import SwiftUI

struct WeatherDaysView: View {
    var weather: WeatherResponse
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 20) {
                ForEach(0..<weather.forecast.weather24hours.count) { index in
                    VStack {
                        Text(index == 0 ? "Current" : weather.forecast.weather24hours[index].timeHour)
                            .font(.system(size: 16, weight: .medium, design: .default))
                            .foregroundStyle(.white)
                        
                        Image(weather.forecast.weather24hours[index].isDay == 1 ? weather.forecast.weather24hours[index].condition.weatherCondition.symbolNameDay : weather.forecast.weather24hours[index].condition.weatherCondition.symbolNameNight)
                            .symbolRenderingMode(.multicolor)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                        
                        Text("\(Int(weather.forecast.weather24hours[index].tempC))°")
                            .font(.system(size: 20, weight: .medium, design: .default))
                            .foregroundColor(.white)
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
    WeatherDaysView(weather: WeatherResponse.sample)
}
