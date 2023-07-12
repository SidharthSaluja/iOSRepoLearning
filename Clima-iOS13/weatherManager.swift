//
//  weatherManager.swift
//  Clima
//
//  Created by Sidharth Saluja on 7/8/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpateWeather(_ weatherManager: WeatherManager, weather: weatherModel)
    func didFailError(error: Error)
}
struct WeatherManager{
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=621e674cec30788e81e7514824e511a8&units=metric"
   
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(urlString: urlString)
        
    }
    
    var delegate: WeatherManagerDelegate?
    
    func performRequest(urlString: String){
        // Create a url
        if let url = URL(string: urlString){
            // create url session
            let session = URLSession(configuration: .default)
            // give session a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil{
                    self.delegate?.didFailError(error: error!)
                    return
                }
                if let safeData = data{
                    if let weather = self.parseJson(weatherDataVar: safeData){
                        self.delegate?.didUpateWeather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
        
    }
    
    func parseJson(weatherDataVar: Data) -> weatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(weatherData.self, from: weatherDataVar)
            let id = decodedData.weather[0].id
            let name = decodedData.name
            let temp = decodedData.main.temp
            let weather = weatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
        }
        catch{
            delegate?.didFailError(error: error)
            return nil
        }
    }
    
    
}
