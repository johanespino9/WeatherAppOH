//
//  MapViewModel.swift
//  WeatherAppOH
//
//  Created by Johan Espino on 21/10/21.
//

import Foundation
import SwiftUI
import Combine

class MapViewModel: ObservableObject {
    @Published var weatherObj: Weather?
    
    let apiService = APIService()
    
    func getWeatherByCity(cityName: String, completion: @escaping (Bool) -> Void) {
        apiService.getWeatherByCityName(cityName: cityName) { success, weather in
            DispatchQueue.main.async {
            if success {
                self.weatherObj = weather
                self.weatherObj?.iconName = iconMap[weather.description] ?? ""
                self.weatherObj?.description = weatherInSpanish[weather.description] ?? ""
                debugPrint("PRUEBA: \(weather.description)")
                debugPrint("PRUEBA: \(iconMap[weather.description] ?? "")")
                completion(success)
            } else {
                completion(success)
            }
            }
            
        }
    }
    
}

private let weatherInSpanish = [
    "Drizzle": "LLovizna",
    "Thunderstorm": "Tormenta",
    "Rain": "LLuvia",
    "Snow": "Nevado",
    "Clear": "Despejado",
    "Clouds": "Nublado",
]

private let iconMap = [
    "Drizzle": "🌧",
    "Thunderstorm": "⛈",
    "Rain": "🌧",
    "Snow": "🌨",
    "Clear": "☀️",
    "Clouds": "☁️",
]
