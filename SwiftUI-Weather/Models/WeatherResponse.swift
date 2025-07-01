//
//  Weather.swift
//  SwiftUI-Weather
//
//  Created by Дмитро Сокотнюк on 02.07.2025.
//

import Foundation

extension WeatherResponse {
    static var sample: WeatherResponse {
        let data = try! Data(contentsOf: Bundle.main.url(forResource: "sample", withExtension: "json")!)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try! decoder.decode(WeatherResponse.self, from: data)
    }
}


struct WeatherResponse: Codable {
    var location: WeatherLocation
    var current: Current
    var forecast: Forecast
}

struct WeatherLocation: Codable {
    var name: String
    var country: String
    var localtime: String
    
    var date: String {
        localtime.toFullDateString() ?? "N/A"
    }
    
}

struct Current: Codable {
    var tempC: Double
    var condition: Condition
}

struct Forecast: Codable {
    var forecastday: [ForecastDay]
    
    var weather24hours: [Hour] {
        let currentHour = Calendar.current.component(.hour, from: Date())
        
        return Array (
            forecastday
                .enumerated()
                .flatMap { index, day in
                    let hours = day.hour
                    let slice = (index == 0 ? hours[currentHour..<hours.count] : hours[0..<currentHour])
                    return slice
                }
                .prefix(24)
        )
    }
}


struct ForecastDay: Codable {
    var day: Day
    var date: String
    var hour: [Hour]
    
    
    var dayOfWeek: String {
        date.toShortWeekdayString() ?? "N/A"
    }
}

struct Day: Codable {
    var maxtempC: Double
    var mintempC: Double
    var condition: Condition
    var maxwindKph: Double
}

struct Hour: Codable {
    var time: String
    var tempC: Double
    var condition: Condition
    var isDay: Int = 1
    
    var timeHour: String {
        time.toHourString() ?? "N/A"
    }
}

struct Condition: Codable {
    var text: String
    var code: Int
    
    var weatherCondition: WeatherCondition {
        WeatherCondition(rawValue: code) ?? .unknow
    }
}

enum WeatherCondition: Int, Codable {
    case sunny                                = 1000
    case partlyCloudy                         = 1003
    case cloudy                               = 1006
    case overcast                             = 1009
    case mist                                 = 1030
    case patchyRainPossible                   = 1063
    case patchySnowPossible                   = 1066
    case patchySleetPossible                  = 1069
    case patchyFreezingDrizzlePossible        = 1072
    case thunderyOutbreaksPossible            = 1087
    case blowingSnow                          = 1114
    case blizzard                             = 1117
    case fog                                  = 1135
    case freezingFog                          = 1147
    case patchyLightDrizzle                   = 1150
    case lightDrizzle                         = 1153
    case freezingDrizzle                      = 1168
    case heavyFreezingDrizzle                 = 1171
    case patchyLightRain                      = 1180
    case lightRain                            = 1183
    case moderateRainAtTimes                  = 1186
    case moderateRain                         = 1189
    case heavyRainAtTimes                     = 1192
    case heavyRain                            = 1195
    case lightFreezingRain                    = 1198
    case moderateOrHeavyFreezingRain          = 1201
    case lightSleet                           = 1204
    case moderateOrHeavySleet                 = 1207
    case patchyLightSnow                      = 1210
    case lightSnow                            = 1213
    case patchyModerateSnow                   = 1216
    case moderateSnow                         = 1219
    case patchyHeavySnow                      = 1222
    case heavySnow                            = 1225
    case icePellets                           = 1237
    case lightRainShower                      = 1240
    case moderateOrHeavyRainShower            = 1243
    case torrentialRainShower                 = 1246
    case lightSleetShowers                    = 1249
    case moderateOrHeavySleetShowers          = 1252
    case lightSnowShowers                     = 1255
    case moderateOrHeavySnowShowers           = 1258
    case lightShowersOfIcePellets             = 1261
    case moderateOrHeavyShowersOfIcePellets   = 1264
    case patchyLightRainWithThunder           = 1273
    case moderateOrHeavyRainWithThunder       = 1276
    case patchyLightSnowWithThunder           = 1279
    case moderateOrHeavySnowWithThunder       = 1282
    case unknow                               = 0000
}

extension WeatherCondition {
    // Надає ім’я SF Symbol для кожного стану
    var symbolNameDay: String {
        switch self {
            // ☀️ Сонячна погода
        case .sunny:
            return "sun"
            
            // 🌤 Частково хмарно
        case .partlyCloudy:
            return "sunCloudy"
            
            // ☁️ Хмарно та похмуро
        case .cloudy, .overcast:
            return "cloud"
            
            // 🌫 Туман, прохолодний серпанок
        case .mist, .fog, .freezingFog:
            return "cloudFoggy"
            
            // 🌧 Дощ
        case .patchyRainPossible,
                .patchyLightRain,
                .lightRain,
                .moderateRainAtTimes,
                .moderateRain,
                .heavyRainAtTimes,
                .heavyRain,
                .lightRainShower,
                .moderateOrHeavyRainShower,
                .torrentialRainShower,
                .patchyFreezingDrizzlePossible,
                .patchyLightDrizzle,
                .lightDrizzle,
                .freezingDrizzle,
                .heavyFreezingDrizzle:
            return "rain"
            
            // 🌨 Сніг
        case .patchySnowPossible,
                .patchyLightSnow,
                .patchyModerateSnow,
                .patchyHeavySnow,
                .lightSnowShowers,
                .moderateOrHeavySnowShowers:
            return "cloudSnow"
            
            // 🌨❄️ Мокрий сніг / дрібний град
        case .patchySleetPossible,
                .lightFreezingRain,
                .moderateOrHeavyFreezingRain,
                .lightSleet,
                .moderateOrHeavySleet,
                .lightSleetShowers,
                .moderateOrHeavySleetShowers,
                .icePellets,
                .lightShowersOfIcePellets,
                .moderateOrHeavyShowersOfIcePellets:
            return "sleetSnow"
            
            // ⛈ Гроза з опадами
        case .thunderyOutbreaksPossible,
                .patchyLightRainWithThunder,
                .moderateOrHeavyRainWithThunder,
                .patchyLightSnowWithThunder,
                .moderateOrHeavySnowWithThunder:
            return "thunderstorm"
            
            // 🌬 Поривистий вітер зі снігом
        case .blowingSnow:
            return "windSnow"
            
            // ❄️ Звичайний сніг
        case .blizzard,
                .lightSnow,
                .moderateSnow,
                .heavySnow:
            return "snowflake"
            
        case .unknow:
            return "questionmark.circle"
        }
    }
    
    var symbolNameNight: String {
        switch self {
            // ☀️ Сонячна погода
        case .sunny:
            return "night"
            
            // 🌤 Частково хмарно
        case .partlyCloudy,
                .cloudy,
                .overcast:
            return "cloudNight"
            
            // 🌫 Туман, прохолодний серпанок
        case .mist, .fog, .freezingFog:
            return "cloudFoggyNight"
            
            // 🌧 Дощ
        case .patchyRainPossible,
                .patchyLightRain,
                .lightRain,
                .moderateRainAtTimes,
                .moderateRain,
                .heavyRainAtTimes,
                .heavyRain,
                .lightRainShower,
                .moderateOrHeavyRainShower,
                .torrentialRainShower,
                .patchyFreezingDrizzlePossible,
                .patchyLightDrizzle,
                .lightDrizzle,
                .freezingDrizzle,
                .heavyFreezingDrizzle:
            return "rainNight"
            
            // 🌨 Сніг
        case .patchySnowPossible,
                .patchyLightSnow,
                .patchyModerateSnow,
                .patchyHeavySnow,
                .lightSnowShowers,
                .moderateOrHeavySnowShowers:
            return "snowNight"
            
            // 🌨❄️ Мокрий сніг / дрібний град
        case .patchySleetPossible,
                .lightFreezingRain,
                .moderateOrHeavyFreezingRain,
                .lightSleet,
                .moderateOrHeavySleet,
                .lightSleetShowers,
                .moderateOrHeavySleetShowers,
                .icePellets,
                .lightShowersOfIcePellets,
                .moderateOrHeavyShowersOfIcePellets:
            return "sleetSnowNight"
            
            // ⛈ Гроза з опадами
        case .thunderyOutbreaksPossible,
                .patchyLightRainWithThunder,
                .moderateOrHeavyRainWithThunder,
                .patchyLightSnowWithThunder,
                .moderateOrHeavySnowWithThunder:
            return "thunderstormNight"
            
            // 🌬 Поривистий вітер зі снігом
        case .blowingSnow:
            return "windSnowNight"
            
            // ❄️ Звичайний сніг
        case .blizzard,
                .lightSnow,
                .moderateSnow,
                .heavySnow:
            return "snowflakeNight"
            
        case .unknow:
            return "questionmark.circle"
        }
    }
}





