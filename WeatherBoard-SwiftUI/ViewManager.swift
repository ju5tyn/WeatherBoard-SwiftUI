//
//  ViewRouter.swift
//  WeatherBoard-SwiftUI
//
//  Created by Justyn Henman on 07/11/2020.
//

import Foundation
import SwiftUI
import Combine

class ViewManager: ObservableObject, Identifiable {
    
    enum viewOptions: String{
        case today, tomorrow, details
    }
    
    @Published var currentView: viewOptions = .today
    @Published var menuShown: Bool = false
    
    @Published var currentCell: Int = 0
    @Published var currentGradient: String = "clear_day"
    
    @Published var weatherModel: WeatherModel? = nil
    
    var isBlurred: Bool{
        return currentView == .details ? true : false
    }
    
    
}
