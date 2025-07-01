//
//  WeatherViewModel.swift
//  SwiftUI-Weather
//
//  Created by Дмитро Сокотнюк on 05.07.2025.
//

import Foundation

@MainActor
class WeatherViewModel: ObservableObject {
    @Published var weather: WeatherResponse?
    @Published var isLoading = false
    @Published var errorMessage: String = ""
    
    private let service: APIService
    private let city: String
    
    init(service: APIService = APIService(), city:String = "Kyiv") {
        self.service = service
        self.city = city
//        Task { await loadWeather() }
    }
    
    func loadWeather() async {
        isLoading = true
        
        do {
            weather = try await service.getWeather(for: city)
            isLoading = false
        } catch WeatherError.invalidResponse {
            errorMessage = "Invalid response from server"
            print(errorMessage)
        } catch WeatherError.invalidData {
            errorMessage = "Invalid data received from server"
            print(errorMessage)
        } catch WeatherError.invalidURL {
            errorMessage = "Invalid URL"
            print(errorMessage)
        } catch {
            errorMessage = error.localizedDescription
            print(errorMessage)
        }
    }
}
