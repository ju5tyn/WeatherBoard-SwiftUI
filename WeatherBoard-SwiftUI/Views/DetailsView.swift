//
//  DetailsView.swift
//  WeatherBoard-SwiftUI
//
//  Created by Justyn Henman on 07/11/2020.
//

import SwiftUI

//MARK: - Details View

//let shadowColor = Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.2)


struct DetailsView: View{
    
    @ObservedObject var viewRouter = ViewRouter()
    
    var body: some View{
        
        ScrollView{
            ForEach(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { id in
                DetailsCell(extended: false, id: id, viewRouter: viewRouter)
            }

        }
        
    }
}

//MARK: Details Cell

struct DetailsCell: View{
    
    
    
    @State var extended: Bool
    
    var id: Int
    @ObservedObject var viewRouter = ViewRouter()
    
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
                        .frame(width: extended ? 110 : 50, height: extended ? 110 : 50, alignment: .center)
                }
                .padding(.bottom, -5)
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Today")
                        .shadow(color: shadowColor, radius: 3.5, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 2)
                        .font(extended ? exDayFont : dayFont)
                        .opacity(extended ? 0.6 : 1)
                    if extended{
                        Text("Clear")
                            .shadow(color: shadowColor, radius: 3.5, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 2)
                            .font(conditionFont)
                            .opacity(extended ? 1 : 0)
                    }
                }
                Spacer()
                Text("19°")
                    .shadow(color: shadowColor, radius: 3.5, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 2)
                    .font(extended ? exTempFont : tempFont)
                if extended{
                    VStack {
                        Text("19°")
                            .shadow(color: shadowColor, radius: 3.5, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 2)
                            .font(hiLoFont)
                            .opacity(0.6)
                        Text("19°")
                            .shadow(color: shadowColor, radius: 3.5, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 2)
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
        
        .padding(.horizontal, 30.0)
        .animation(.easeInOut(duration: 0.2))
        .contentShape(Rectangle())
        .onTapGesture(perform: {
            viewRouter.currentCell = id
        })
        .onAppear(perform: {
            extended = viewRouter.currentCell == id ? true : false
        })
        .onChange(of: viewRouter.currentCell, perform: { value in
            extended = viewRouter.currentCell == id ? true : false
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
                .opacity(0.2)
                .shadow(color: Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.5), radius: 2, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y:2)
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
                        .shadow(color: shadowColor, radius: 3.5, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 2)
                    Text("40MPH")
                        .font(rectSmallFont)
                        .padding(.bottom, 5)
                        .shadow(color: shadowColor, radius: 3.5, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 2)
                }else{
                    
                    Text("16KM")
                        .font(rectLargeFont)
                        .padding(.top, 10)
                        .shadow(color: shadowColor, radius: 3.5, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 2)
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
