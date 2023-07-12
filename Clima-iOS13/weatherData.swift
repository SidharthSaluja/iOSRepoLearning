//
//  weatherData.swift
//  Clima
//
//  Created by Sidharth Saluja on 7/9/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

struct weatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
    
}
