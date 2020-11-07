//
//  ContentView.swift
//  WeatherBoard-SwiftUI
//
//  Created by Justyn Henman on 05/11/2020.
//

import SwiftUI

struct MainView: View {
    
    
    
    //view
    var body: some View {
        VStack {
            HStack {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {Image("menu_24pt_white")} )
                    .padding([.top, .leading], 25.0)
                    .padding(.bottom, 20.0)
                Spacer()
            }
            DetailsView()
            Spacer()
            NavBar()
                .padding(.bottom, 30)
        }
    }
}


//MARK: - Navigation Bar

struct NavBar: View{
    
    let navFont = Font.custom("SFCompactText-Bold", size: 16)
    
    var body: some View {
    
        HStack{
            Spacer()
            Button(action: {}) {
                Text("TODAY")
                    .foregroundColor(.white)
                    .font(navFont)
                    .frame(width: 93.5, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
            Spacer(minLength: 23)
            Button(action: {}) {
                Text("TOMORROW")
                    .foregroundColor(.white)
                    .font(navFont)
                    .frame(width: 93.5, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
            Spacer(minLength: 23)
            Button(action: {}) {
                Text("MORE")
                    .foregroundColor(.white)
                    .font(navFont)
                    .frame(width: 93.5, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
            Spacer()
        }
    }
}



//MARK: - Details View

struct DetailsView: View{
    
    var body: some View{
        
        List{
            DetailsCell(extended: true)
            DetailsCell(extended: false)
            DetailsCell(extended: false)
            DetailsCell(extended: false)
            DetailsCell(extended: false)
        }
        .padding(.horizontal, 15.0)
        
        
    }
    
}

//MARK: Details Cell

struct DetailsCell: View{
    
    @State var extended: Bool
    
    let exDayFont = Font.custom("SFCompactText-Bold", size: 15)
    let dayFont = Font.custom("SFCompactText-Bold", size: 20)
    let conditionFont = Font.custom("SFCompactText-Bold", size: 35)
    let hiLoFont = Font.custom("SFCompactText-Bold", size: 18)
    let exTempFont = Font.custom("SFCompactText-Bold", size: 50)
    let tempFont = Font.custom("SFCompactText-Bold", size: 25)
    
    
    
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
            
        }.animation(.default)
    }
}

//MARK: Details Rect

struct DetailsRect: View{
    
    enum IconType{ case rain, wind, cloud, visibility }
    
    let hasSubheading: Bool
    let icon: IconType
    
    let rectLargeFont = Font.custom("SFCompactText-Bold", size: 20)
    let rectMedFont = Font.custom("SFCompactText-Bold", size: 15)
    let rectSmallFont = Font.custom("SFCompactText-Bold", size: 12)
    
    var body: some View{
        
        ZStack {
            Rectangle()
                .cornerRadius(10)
                .opacity(0.5)
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

//MARK: - preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainView()
                .previewDevice("iPhone XS")
                .preferredColorScheme(.dark)
        }
    }
}



