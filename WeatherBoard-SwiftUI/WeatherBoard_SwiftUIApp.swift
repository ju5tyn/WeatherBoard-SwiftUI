//
//  WeatherBoard_SwiftUIApp.swift
//  WeatherBoard-SwiftUI
//
//  Created by Justyn Henman on 05/11/2020.
//

import SwiftUI

import Foundation

@main
struct WeatherBoard_SwiftUIApp: App {
    
    
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .colorScheme(.dark)
                .onAppear(perform: {
                    
                    
                })
            
            
        }
    }
}


