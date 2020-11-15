import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}



struct WeatherManager {
    
    var delegate: WeatherManagerDelegate?
    
    let weatherURL = "\(Constants.mainURL)\(Keys.openweathermap)"
    
    //MARK: Fetch Weather
    
    func fetchWeather(cityName: String, doNotSave: Bool) {
        
        //converts search to lat+lon
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(cityName) { placemarks, error in
            
            let placemark = placemarks?.first
            if let lat = placemark?.location?.coordinate.latitude, let lon = placemark?.location?.coordinate.longitude {
                let urlString = "\(weatherURL)&lat=\(lat)&lon=\(lon)"
                performRequest(with: urlString, isCurrentLocation: false, doNotSave: doNotSave)
            }else{
                //protection for if search fails. Might replace with a wrong location warning
                //let urlString = "\(weatherURL)&q=\(cityName)"
                //performRequest(with: urlString, isCurrentLocation: false,
            }
        }
    }
    
    func fetchWeather(latitude: Double, longitude: Double){
        //From location
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        print("ios gave locaiton")
        performRequest(with: urlString, isCurrentLocation: true, doNotSave: false)
    }
    
    
    func performRequest(with urlString: String, isCurrentLocation: Bool, doNotSave: Bool) {
        //Create a url
        
        if let url = URL(string: urlString){
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {
                
                (data, response, error) in
                
                    if error != nil{
                        //print(error!)
                        self.delegate?.didFailWithError(error: error!)
                        return
                    }
                    
                    
                    if let safeData = data {
                        if let weather = self.parseJSON(safeData, isCurrentLocation: isCurrentLocation, doNotSave: doNotSave) {
                            self.delegate?.didUpdateWeather(self, weather: weather)
                        }
                    }
            }
            
            task.resume()
            
        }
        
    }
    
    func parseJSON(_ data: Data, isCurrentLocation: Bool, doNotSave: Bool) -> WeatherModel? {
        
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: data)
            
            
            
            
            return WeatherModel(lat: decodedData.lat,
                                lon: decodedData.lon,
                                timeZoneOffset: decodedData.timezone_offset,
                                isCurrentLocation: false,
                                doNotSave: false,
                                current: getCurrent(decodedData),
                                daily: getDailyArray(decodedData)
            )
            
        } catch {
            delegate?.didFailWithError(error: error)
            print(error)
            return nil
        }
            
        
        
    }

    func getCurrent(_ decodedData: WeatherData) -> WeatherModel.Current{
        
        let data = decodedData.current
        
        return WeatherModel.Current(id: data.weather[0].id,
                                    main: data.weather[0].main,
                                    dt: data.dt,
                                    sunrise: data.sunrise,
                                    sunset: data.sunset,
                                    temp: data.temp
        )
        
        
    }
    
    func getDailyArray(_ decodedData: WeatherData) -> [WeatherModel.Daily]{
        var array: [WeatherModel.Daily] = []
        for day in 0...4{ array.append(getDaily(decodedData, day)) }
        return array
    }
    
    
    func getDaily(_ decodedData: WeatherData, _ day: Int) -> WeatherModel.Daily{
        
        let data = decodedData.daily[day]
        
        return WeatherModel.Daily(id: data.weather[0].id,
                                  main: data.weather[0].main,
                                  dt: data.dt,
                                  sunrise: data.sunrise,
                                  sunset: data.sunset,
                                  temp: data.temp.day,
                                  highTemp: data.temp.max,
                                  lowTemp: data.temp.min,
                                  cloudCover: data.clouds,
                                  windSpeed: data.wind_speed,
                                  windDirection: data.wind_deg,
                                  precip: data.pop,
                                  visibility: data.visibility)
        
    }
    
}


