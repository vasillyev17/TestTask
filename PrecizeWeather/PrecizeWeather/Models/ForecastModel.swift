//
//  ForecastModel.swift
//  PrecizeWeather
//
//  Created by ihor on 06.01.2023.
//

import Foundation

struct Forecast: Codable {
    let cod: String
    let message: Int
    let cnt: Int
    let list: [DailyForecast]
    let city: City
}

struct DailyForecast: Codable {
    let dt: Int
    let main: Characteristics
    let weather: [Weather]
    let wind: Wind
    let visibility: Int
    let dt_txt: String
}

struct Characteristics: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Double
    let sea_level: Double
    let grnd_level: Double
    let humidity: Double
    let temp_kf: Double
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Wind: Codable {
    let speed: Double
    let deg: Double
    let gust: Double
}

struct City: Codable {
    let id: Int
    let name: String
    let coord: Coordinate
    let country: String
    let population: Int
    let timezone: Int
    let sunrise: Int
    let sunset: Int
}

struct Coordinate: Codable {
    let lat: Double
    let lon: Double
}
