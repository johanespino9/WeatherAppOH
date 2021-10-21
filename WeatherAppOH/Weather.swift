//
//  Weather.swift
//  WeatherAppOH
//
//  Created by Johan Espino on 21/10/21.
//

import Foundation

struct Weather: Codable {
    var cityName: String
    var latitude: Double
    var longitude: Double
    var temperature: Double
    var description: String
    var iconName: String
}
