//
//  ContentView.swift
//  WeatherBoard-SwiftUI
//
//  Created by Justyn Henman on 05/11/2020.
//

import SwiftUI
import Combine

let shadowColor = Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.2)

struct MainView: View {
    
    @ObservedObject var viewRouter = ViewRouter()
    
    let bgGradient = Gradient(colors: [Color("grad_clear_day_top"), Color("grad_clear_day_bottom")])
    let hillGradient = Gradient(colors: [Color("hill_clear_day_top"), Color("hill_clear_day_bottom")])
    
    
    //view
    var body: some View {
        ZStack {
            Group {
                Background(viewRouter: viewRouter)
                    .blur(radius: viewRouter.isBlurred && !viewRouter.menuShown ? 40 : 0)
                    .scaleEffect(x: viewRouter.isBlurred && !viewRouter.menuShown ? 1.3 : 1, y: viewRouter.isBlurred && !viewRouter.menuShown ? 1.1 : 1, anchor: .center)
                    .saturation(viewRouter.isBlurred && !viewRouter.menuShown ? 1.2 : 1)
                    .animation(.easeInOut(duration: 0.2))
                Rectangle()
                    .foregroundColor(viewRouter.isBlurred && !viewRouter.menuShown ? Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.1) : .clear)
            }
            .edgesIgnoringSafeArea(.all)
            VStack {
                //Menu button
                MenuBar(viewRouter: viewRouter)
                if(viewRouter.menuShown){
                    MenuView()
                }else if(self.viewRouter.currentView == .details){
                    DetailsView()
                }else{
                    WeatherView()
                }
                Spacer()
                NavBar(viewRouter: viewRouter)
            }.animation(.easeInOut(duration: 0.2))
        }
    }
}

struct MenuBar: View {
    
    @ObservedObject var viewRouter = ViewRouter()
    
    let cancelIcon = Image(Strings.menuBar.cancel)
    let locationIcon = Image(Strings.menuBar.location)
    let menuIcon = Image(Strings.menuBar.menu)
    
    let titleText = Text("WeatherBoard")
        .font(Font.custom(Strings.font, size: 24))
    
    var body: some View{
        HStack{
            Button(action: {
                viewRouter.menuShown.toggle()
            }, label: {viewRouter.menuShown ? cancelIcon : menuIcon} )
                .shadow(color: shadowColor, radius: 3.5, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 2)
            Spacer()
            titleText
                .opacity(viewRouter.menuShown ? 1 : 0)
            Spacer()
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {viewRouter.menuShown ? locationIcon : nil} )
                .shadow(color: shadowColor, radius: 3.5, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 2)
            
        }
        .padding(.horizontal, 30.0)
        .padding(.vertical, 25)
        
    }
    
    
    
    
    
}


//MARK: - Blur effect

struct Background: View{
    
    @ObservedObject var viewRouter = ViewRouter()
    
    let bgGradient = Gradient(colors: [Color("grad_clear_day_top"), Color("grad_clear_day_bottom")])
    let hillGradient = Gradient(colors: [Color("hill_clear_day_top"), Color("hill_clear_day_bottom")])
    
    let menuBgGradient = Gradient(colors: [Color("grad_menu_top"), Color("grad_menu_bottom")])
    let menuHillGradient = Gradient(colors: [Color("grad_menu_top"), Color("grad_menu_bottom")])
    
    
    var body: some View{
        
        LinearGradient(gradient: viewRouter.menuShown ? menuBgGradient : bgGradient, startPoint: /*@START_MENU_TOKEN@*/.top/*@END_MENU_TOKEN@*/, endPoint: UnitPoint(x: 0.5, y: 0.6)).edgesIgnoringSafeArea(.all)
            .animation(.easeInOut(duration: 1))
        LinearGradient(gradient: viewRouter.menuShown ? menuHillGradient : hillGradient, startPoint: UnitPoint(x: 0.5, y: 0.8), endPoint: /*@START_MENU_TOKEN@*/.bottom/*@END_MENU_TOKEN@*/)
            .animation(.easeInOut(duration: 1))
            .mask(
            VStack {
                Spacer()
                Image("hills")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    
            })
            .edgesIgnoringSafeArea(.vertical)
            
    }
    
}

//MARK: - Navigation Bar

struct NavBar: View{
    
    @ObservedObject var viewRouter: ViewRouter
    
    let navFont = Font.custom(Strings.font, size: 16)
    let shadowColor = Color(red: 1.0, green: 0.0, blue: 0.0, opacity: 0.3)
    
    var body: some View {
    
        HStack{
            if viewRouter.menuShown{
                Spacer()
            }else{
                Spacer()
                Button(action: {viewRouter.currentView = .today}) {
                    Text("TODAY")
                        .foregroundColor(.white)
                        .opacity(viewRouter.currentView == .today ? 1 : 0.5)
                        .font(navFont)
                        .frame(width: 93.5, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .shadow(color: shadowColor, radius: 3.5, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 2)
                }
                Spacer(minLength: 23)
                Button(action: {viewRouter.currentView = .tomorrow}) {
                    Text("TOMORROW")
                        .foregroundColor(.white)
                        .opacity(viewRouter.currentView == .tomorrow ? 1 : 0.5)
                        .font(navFont)
                        .frame(width: 93.5, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .shadow(color: shadowColor, radius: 3.5, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 2)
                }
                Spacer(minLength: 23)
                Button(action: {viewRouter.currentView = .details}) {
                    Text("MORE")
                        .foregroundColor(.white)
                        .opacity(viewRouter.currentView == .details ? 1 : 0.5)
                        .font(navFont)
                        .frame(width: 93.5, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .shadow(color: shadowColor, radius: 3.5, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 2)
                }
                Spacer()
                }
        }
        .padding(.bottom, 30)
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



