//
//  WeatherModel.swift
//  Clima
//
//  Created by Justyn Henman on 07/07/2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation



struct WeatherModel{
    
    
    
    //MARK: global attributes
    let timeZone: Int
    let cityName: String
    let sunrise: Int
    let sunset: Int
    let dt: Double
    let isCurrentLocation: Bool
    let doNotSave: Bool
    
    let conditionID: [Int]
    
    let dailyArray: [dailyForecast]
    
    //5day forecast
    
    struct dailyForecast{
        
        let conditionID: Int
        
        let dt: Double
        
        var dayString: String{
            let date = Date(timeIntervalSince1970: dt)
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
            dateFormatter.locale = NSLocale.current
            dateFormatter.dateFormat = "EEEE" //Specify your format that you want
            return dateFormatter.string(from: date)
        }
        
        var conditionName: String{
            return getIconName(conditionID)
        }
        
        let description: String
        
        let temp: Double
        var tempString: String{
            return "\(String(format: "%.0f", temp))°"
        }
        
        let highTemp: Double
        var highTempString: String{
            return "\(String(format: "%.0f", temp))°"
        }
        
        let lowTemp: Double
        var lowTempString: String{
            return "\(String(format: "%.0f", temp))°"
        }
        
        let cloudCover: Int
        var cloudCoverString: String{
            return "\(cloudCover)%"
        }
        
        let windSpeed: Double
        var windSpeedString: String{
            return String(format: "%.1fM/S", Double(windSpeed))
        }
        
        let windDirection: Double
        var windDirectionString: String{
            return windDirection.direction.description.uppercased()
        }
        
        let precip: Double
        var precipString: String{
            return "\(String(format: "%.0f", precip*100))%"
        }
        
        
        let visibility: Double
        // this is in metres
        // below returns visibility string in KM
        var visibilityString: String{
            return String(format: "%.0fKM", Double(visibility/1000))
        }

    }
    
    //MARK: global calculated
    
    var timeString: String {
        
        //returns time from selected location
        return Date(timeInterval: TimeInterval(timeZone), since: Date()).UTCTimeString
        
    }
    
    var isDay: Bool {
        
        return (Int(dt)>sunrise && Int(dt)<sunset) ? true : false
        
    }
    
    var isDayString: String{
        
        return isDay ? "day" : "night"
        
    }
    
    var particleToDisplay: [String?]{
        
        return [getParticleName(conditionID[0]),
                getParticleName(conditionID[1])]
        
    }
    
    func getParticleName(_ conditionID: Int) -> String? {
        
        let iconName = getIconName(conditionID)
        
        switch iconName{
        
            case "rain", "rain_clouds", "shower_rain":
                return C.particles.rainParticle
                
            case "thunderstorm":
                return C.particles.stormParticle
                
            case "snow":
                return C.particles.snowParticle
                
            case "clear", "few_clouds":
                if self.isDay{
                    return nil
                }else{
                    return C.particles.starParticle
                }
                
            case "scattered_clouds", "broken_clouds":
                if self.isDay{
                    return nil
                }else{
                    return C.particles.starParticleCloudy
                }
                
            default:
                return nil
            }
        
    }

}



func getIconName(_ conditionID: Int) -> String{
    
    //print(conditionID)
    
    switch conditionID{
        
        //add on night day after
        
        case 200...299:
            return "thunderstorm"
        
        case 300...399:
            return "rain"
        
        case 500...504:
            return "rain_clouds"
        
        case 511:
            return "snow"
        
        case 520...599:
            return "shower_rain"
        
        case 600...699:
            return "snow"
        
        case 700...780:
            return "mist"
        
        case 781:
            return "thunderstorm"
    
        case 800:
            return "clear"
    
        case 801:
            return "few_clouds"
            
        case 802...803:
            return "scattered_clouds"
            
        case 804...804:
            return "broken_clouds"

        default:
            return "scattered_clouds"
        
    }
    
}

extension Date {

   var UTCTimeString: String {
        
        //dateformatter for time thing
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.dateFormat = "H:mm"
    
        return formatter.string(from: self)
    
    }
    
    
}