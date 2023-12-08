//
//  GetWeatherInfo.swift
//  Weather
//
//  Created by Sudhir Pawar on 20/09/23.
//

import Foundation

class GetWeatherInfoViewModel: NSObject {
    private let baseURLString: String
    private let apiKey: String
    private let hostURLString: String
    let headers: [String: String]
    private var locationName = String()
    private var locationRegion = String()

    private let path = "san fransico"

    var weatherDataReceived: ((WeatherDataModel) -> Void)?

    override init() {
        self.baseURLString = Constants.baseURLWeather
        self.apiKey = Constants.rapidAPIKey
        self.hostURLString = Constants.hostWeather

        self.headers = [
            "X-RapidAPI-Key":  apiKey,
            "X-RapidAPI-Host": hostURLString
        ]
    }

    func getWeather(for locationName:String) {
        if let encodedLocationName = locationName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
        let url = URL(string: baseURLString + encodedLocationName) {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = headers

            URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data, error == nil else {
                    print(error?.localizedDescription ?? "Unknown Error")
                    return
                }

                if let httpResponse = response as? HTTPURLResponse {
//                    print(httpResponse)
                }

                do {
                    if let responseDict = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                       let locationDict = responseDict["location"] as? [String: Any],
                       let currentDict = responseDict["current"] as? [String: Any] {

                        // Extract data from locationDict
                        let name = locationDict["name"] as? String ?? ""
                        let region = locationDict["region"] as? String ?? ""
                        let country = locationDict["country"] as? String ?? ""
                        var text = ""
                        var icon = ""
                        // Extract data from currentDict
                        if let conditionDict = currentDict["condition"] as? [String: Any] {
                             text = conditionDict["text"] as? String ?? ""
                             icon = conditionDict["icon"] as? String ?? ""
                        }
                        let tempC = currentDict["temp_c"] as? Double ?? 0.0
                        let lastUpdated = currentDict["last_updated"] as? String ?? ""
                        let windKph = currentDict["wind_kph"] as? Double ?? 0.0
                        let humidity = currentDict["humidity"] as? Int ?? 0
                        let feelslikeC = currentDict["feelslike_c"] as? Double ?? 0.0
                        let visKm = currentDict["vis_km"] as? Double ?? 0.0
                        let uv = currentDict["uv"] as? Int ?? 0

                        // Create a WeatherDataModel object
                        let weatherData = WeatherDataModel(name: name, region: region, country: country, text: text, icon: icon, tempC: tempC, lastUpdated: lastUpdated, windKph: windKph, humidity: humidity, feelslikeC: feelslikeC, visKm: visKm, uv: uv)

                        // Use the closure to pass the data to the ViewController
                        self.weatherDataReceived?(weatherData)
                        print("In the main file")
                    }
                } catch {
                    print("Error parsing JSON: \(error)")
                }
            }.resume()
        }
    }
}
