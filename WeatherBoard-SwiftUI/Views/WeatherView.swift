//
//  WeatherView.swift
//  WeatherBoard-SwiftUI
//
//  Created by Justyn Henman on 07/11/2020.
//

import SwiftUI
import Combine
//MARK: - Weather View


struct WeatherView: View{
    
    var viewManager = ViewManager()
    
    let largeFont = Font.custom("SFCompactText-Bold", size: 34)
    let smallFont = Font.custom("SFCompactText-Bold", size: 17)
    let shadowColor = Color(red: 1.0, green: 0.0, blue: 0.0, opacity: 0.3)
    
    var body: some View{
        
        if viewManager.weatherModel != nil{
            VStack{
                
                Image("icon_\(viewManager.weatherModel!.current.conditionName)_\(viewManager.weatherModel!.current.isDayString)")
                    .frame(width: 140, height: 140, alignment: .center)
                Text("\(viewManager.weatherModel!.current.tempString) \(viewManager.weatherModel!.current.main)")
                    .foregroundColor(.white)
                    .font(largeFont)
                    .padding(.bottom, 3)
                    .shadow(color: shadowColor, radius: 3.5, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 2)
                Text("\(viewManager.weatherModel!.timeString) - \(viewManager.weatherModel!.locationName!)")
                    .foregroundColor(.white)
                    .font(smallFont)
                    .shadow(color: shadowColor, radius: 3.5, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 2)
                    
            }
        }
        
    
    }
    
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
