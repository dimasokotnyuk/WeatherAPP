//
//  Weather10Days.swift
//  SwiftUI-Weather
//
//  Created by Дмитро Сокотнюк on 05.07.2025.
//

import SwiftUI

struct Weather10DaysView: View {
    var weather: WeatherResponse
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Image(systemName: "calendar")
                    .foregroundStyle(.white)
                Text("10-day weather forecast")
                    .foregroundStyle(.white)
            }
            .padding(.vertical, 10)
            
            CustomDivider()
            
            ForEach(0..<weather.forecast.forecastday.count) { index in
                HStack(spacing: 16) {
                    // День тижня - фіксована ширина
                    Text(index == 0 ? "Current" : weather.forecast.forecastday[index].dayOfWeek)
                        .font(.system(size: 16, weight: .medium, design: .default))
                        .foregroundStyle(.white)
                        .frame(width: 60, alignment: .leading)
                    
                    // Іконка погоди - центрування
                    Image(weather.forecast.forecastday[index].day.condition.weatherCondition.symbolNameDay)
                        .symbolRenderingMode(.multicolor)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                    
                    Spacer()
                    
                    // Температура - вирівнювання по правому краю
                    Text("\(Int(weather.forecast.forecastday[index].day.mintempC))° - \(Int(weather.forecast.forecastday[index].day.maxtempC))°")
                        .font(.system(size: 16, weight: .medium, design: .default))
                        .foregroundColor(.white.opacity(0.8))
                    
                    
                    Text("\(Image(systemName: "wind")) - \(Int(weather.forecast.forecastday[index].day.maxwindKph)) km/h")
                        .lineLimit(1)
                        .foregroundStyle(.white)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                
                // Роздільник (крім останнього елемента)
                if index < weather.forecast.forecastday.count - 1 {
                    CustomDivider()
                }
            }
        }
        .padding(.vertical, 8)
        .background(.ultraThinMaterial.opacity(0.4))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .frame(maxWidth: UIScreen.main.bounds.width * 0.9) // 90% ширини екрану
    }
}

#Preview {
    Weather10DaysView(weather: WeatherResponse.sample)
}
