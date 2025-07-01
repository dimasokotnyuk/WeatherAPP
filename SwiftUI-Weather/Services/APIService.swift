//
//  APIService.swift
//  SwiftUI-Weather
//
//  Created by Дмитро Сокотнюк on 02.07.2025.
//

import Foundation

enum WeatherError: Error {
    case invalidURL, invalidResponse, invalidData
}

struct APIService {
    let apiKey = "947d7d3238694a37a63145024250407"
    
    func getWeather(for city: String) async throws -> WeatherResponse {
        var components = URLComponents(string: "https://api.weatherapi.com/v1/forecast.json")
        components?.queryItems = [
            URLQueryItem(name: "key", value: apiKey),
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "days", value: "10")
        ]
        
        guard let url = components?.url else {
            throw WeatherError.invalidURL
        }
        
        let(data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw WeatherError.invalidResponse
        }
        
        do {
            let decodeer = JSONDecoder()
            decodeer.keyDecodingStrategy = .convertFromSnakeCase
            return try decodeer.decode(WeatherResponse.self, from: data)
        } catch {
            throw WeatherError.invalidData
        }
    }
    
}
