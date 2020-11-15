//
//  Strings.swift
//  WeatherBoard-SwiftUI
//
//  Created by Justyn Henman on 07/11/2020.
//

import Foundation
import SwiftUI

struct Constants {
    
    
    //font string
    static let font = "SFCompactText-Bold"
    
    static let mainURL = "https://api.openweathermap.org/data/2.5/onecall?units=metric&appid="

    struct menuBar {
        
        static let menu = "menu"
        static let location = "location"
        static let back = "back"
        static let cancel = "cancel"
        
    }
    
    struct grad {
        
        static let defaultBg: [Color] = [Color("grad_clear_day_top"),
                                             Color("grad_clear_day_bottom")]
        static let defaultHill: [Color] = [Color("hill_menu_top"),
                                               Color("hill_menu_bottom")]
        
    }
    
    struct particles{
        
        static let rainParticle = "RainParticle.sks"
        static let snowParticle = "SnowParticle.sks"
        static let stormParticle = "StormParticle.sks"
        static let starParticle = "StarParticle.sks"
        static let starParticleCloudy = "StarParticleCloudy.sks"
        
    }
}
