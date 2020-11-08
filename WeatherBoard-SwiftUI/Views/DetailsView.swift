//
//  DetailsView.swift
//  WeatherBoard-SwiftUI
//
//  Created by Justyn Henman on 07/11/2020.
//

import SwiftUI

//MARK: - Details View

struct DetailsView: View{
    
    var body: some View{
        
        ScrollView{
            DetailsCell(extended: true)
            DetailsCell(extended: false)
            DetailsCell(extended: false)
            DetailsCell(extended: false)
            DetailsCell(extended: false)
        }
        
    }
}

//MARK: Details Cell

struct DetailsCell: View{
    
    @State var extended: Bool
    
    let exDayFont = Font.custom(Strings.font, size: 15)
    let dayFont = Font.custom(Strings.font, size: 20)
    let conditionFont = Font.custom(Strings.font, size: 35)
    let hiLoFont = Font.custom(Strings.font, size: 18)
    let exTempFont = Font.custom(Strings.font, size: 50)
    let tempFont = Font.custom(Strings.font, size: 25)
    
    var body: some View{
        
        VStack {
            if extended{
                HStack{
                    Spacer()
                    Image("icon_clear_day")
                        .resizable()
                        .frame(width: extended ? 100 : 50, height: extended ? 100 : 50, alignment: .center)
                }
                .padding(.bottom, -5)
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Today")
                        .font(extended ? exDayFont : dayFont)
                        .opacity(extended ? 0.6 : 1)
                    if extended{
                        Text("Clear")
                            .font(conditionFont)
                            .opacity(extended ? 1 : 0)
                    }
                }
                Spacer()
                Text("19°")
                    .font(extended ? exTempFont : tempFont)
                if extended{
                    VStack {
                        Text("19°")
                            .font(hiLoFont)
                            .opacity(0.6)
                        Text("19°")
                            .font(hiLoFont)
                            .opacity(0.6)
                    }
                }else{
                    Image("icon_clear_day")
                        .resizable()
                        .frame(width: extended ? 100 : 50, height: extended ? 100 : 50, alignment: .center)
                        .padding(.vertical, 4)
                }
            }.padding(.bottom, -2)
            if extended{
                HStack{
                    DetailsRect(hasSubheading: true, icon: .rain)
                    
                    DetailsRect(hasSubheading: true, icon: .wind)
                    DetailsRect(hasSubheading: false, icon: .cloud)
                    DetailsRect(hasSubheading: false, icon: .visibility)
                }
            }
            
        }
        
        .padding(.horizontal, 25.0)
        .animation(.easeInOut(duration: 0.2))
        .onTapGesture(perform: {
            extended.toggle()
        })
    }
    
    
}

//MARK: Details Rect

struct DetailsRect: View{
    
    enum IconType{ case rain, wind, cloud, visibility }
    
    let hasSubheading: Bool
    let icon: IconType
    
    let rectLargeFont = Font.custom(Strings.font, size: 20)
    let rectMedFont = Font.custom(Strings.font, size: 15)
    let rectSmallFont = Font.custom(Strings.font, size: 12)
    
    var body: some View{
        
        ZStack {
            Rectangle()
                .cornerRadius(10)
                .opacity(0.5)
                .shadow(color: Color(red: 1.0, green: 0.0, blue: 0.0, opacity: 0.2), radius: 2, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y:2)
            VStack{
                switch icon{
                    case .rain:
                        Image("rain")
                            .padding(.top, 8)
                    case .wind:
                        Image("wind")
                            .padding(.top, 5)
                            .padding(.bottom, -5)
                    case .cloud:
                        Image("cloud")
                            .padding(.top, 10)
                    case .visibility:
                        Image("visibility")
                            .padding(.top, 10)
                }
                
                if hasSubheading{
                    Text("NW")
                        .font(rectMedFont)
                    Text("40MPH")
                        .font(rectSmallFont)
                        .padding(.bottom, 5)
                }else{
                    
                    Text("16KM")
                        .font(rectLargeFont)
                        .padding(.top, 10)
                }
                
            }.padding([.top, .bottom], 2)
            
        }
        
    }
    
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView()
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
