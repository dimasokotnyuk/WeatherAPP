//
//  ContentView.swift
//  SwiftUI-Weather
//
//  Created by Дмитро Сокотнюк on 01.07.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = WeatherViewModel()
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        ZStack {
            BackgroundView()
            ScrollView(showsIndicators: false) {
                if let weather = viewModel.weather {
                    VStack {
                        WeatherLocationView(weather: weather)
                        
                        WeatherDaysView(weather: weather)
                        
                        Weather10DaysView(weather: weather)
                    }
                    .transition(.opacity)
                } else {
                    VStack {
                        WeatherLocationPlaceholder()
                        
                        WeatherDaysPlaceholder()
                        
                        Weather10DaysPlaceholder()
                    }
                    .transition(.opacity)
                }
            }
        }
        .animation(.easeInOut(duration: 0.5), value: viewModel.weather != nil)
        .onChange(of: scenePhase) { oldPhase, newPhase in
            if newPhase == .active {
                Task {
                    try await Task.sleep(for: .seconds(2))
                    await viewModel.loadWeather()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
