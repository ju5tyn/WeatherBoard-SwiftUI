//
//  ViewRouter.swift
//  WeatherBoard-SwiftUI
//
//  Created by Justyn Henman on 07/11/2020.
//

import Foundation
import SwiftUI
import Combine

class ViewRouter: ObservableObject {
    
    enum viewOptions: String{
        case today, tomorrow, details
    }
    
    @Published var currentView: viewOptions = .today
    
    var isBlurred: Bool{
        return currentView == .details ? true : false
    }
    
}
