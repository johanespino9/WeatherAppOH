//
//  APIService.swift
//  WeatherAppOH
//
//  Created by Johan Espino on 21/10/21.
//

import Foundation

class APIService {
    private let API_KEY = "55ded09ec6f62c81b6f3ba2c31e56e2f"
    
    private func request(cityName: String, completion: @escaping (Bool, Weather) -> Void){
        guard let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(API_KEY)&units=metric".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil, let data = data else { return }
            debugPrint("RESPONSE: \(response)")
            debugPrint("DATA: \(data)")
            if let response = try? JSONDecoder().decode(APIResponse.self, from: data) {
                let weather = Weather(cityName: response.name, latitude: response.coord.lat, longitude: response.coord.lon, temperature: response.main.temp, description: response.weather.first!.description, iconName: response.weather.first!.description)
                debugPrint(response)
                completion(true, weather)
            } else {
                completion(false,Weather(cityName: "", latitude: 0.0, longitude: 0.0, temperature: 0.0, description: "", iconName: ""))
            }
            
            
        }.resume()
    }
    
    func getWeatherByCityName(cityName: String, completion: @escaping (Bool, Weather) -> Void){
        DispatchQueue.main.async {
            self.request(cityName: cityName){ success, weather in
                completion(success, weather)
            }
        }
        
    }
    
}

struct APIResponse: Decodable {
    let name: String
    let main: MainResponse
    let weather: [WeatherResponse]
    let coord: CoordResponse
}

struct MainResponse: Decodable {
    let temp: Double
}

struct WeatherResponse: Decodable {
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case description = "main"
    }
}

struct CoordResponse: Decodable {
    let lat: Double
    let lon: Double
}


