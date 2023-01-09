//
//  MainViewModel.swift
//  PrecizeWeather
//
//  Created by ihor on 06.01.2023.
//

import Foundation

class MainViewModel {
    
    func loadWeather(lat: String = "50.4500",lng: String = "30.5236", callback: @escaping (Forecast) -> Void) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lng)&units=metric&appid=3b46640a464899b24994c6727a3af61b") else { return }
        let task = URLSession.shared.dataTask(with: url) {data, response, error in
            if let data = data {
                if let weather = try? JSONDecoder().decode(Forecast.self, from: data) {
                    callback(weather)
                } else {
                    print("Invalid Response")
                }
            } else if let error = error {
                print("HTTP Request Failed \(error)")
            }
            
        }
        task.resume()
    }
}
