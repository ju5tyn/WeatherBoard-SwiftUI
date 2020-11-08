//
//  WeatherView.swift
//  WeatherBoard-SwiftUI
//
//  Created by Justyn Henman on 07/11/2020.
//

import SwiftUI

//MARK: - Weather View

struct WeatherView: View{
    
    let largeFont = Font.custom("SFCompactText-Bold", size: 34)
    let smallFont = Font.custom("SFCompactText-Bold", size: 17)
    let shadowColor = Color(red: 1.0, green: 0.0, blue: 0.0, opacity: 0.3)
    
    var body: some View{
        
        VStack{
            Image("icon_clear_day").frame(width: 140, height: 140, alignment: .center)
            Text("19° Clear")
                .foregroundColor(.white)
                .font(largeFont)
                .padding(.bottom, 3)
                .shadow(color: shadowColor, radius: 3.5, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 2)
            Text("12:35 - Sydney")
                .foregroundColor(.white)
                .font(smallFont)
                .shadow(color: shadowColor, radius: 3.5, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 2)
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
