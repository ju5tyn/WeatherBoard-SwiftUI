//
//  ContentView.swift
//  WeatherBoard-SwiftUI
//
//  Created by Justyn Henman on 05/11/2020.
//

import SwiftUI
import Combine

struct MainView: View {
    
    @ObservedObject var viewRouter = ViewRouter()
    
    let bgGradient = Gradient(colors: [Color("grad_clear_day_top"), Color("grad_clear_day_bottom")])
    let hillGradient = Gradient(colors: [Color("hill_clear_day_top"), Color("hill_clear_day_bottom")])
    let shadowColor = Color(red: 1.0, green: 0.0, blue: 0.0, opacity: 0.3)
    

    //view
    var body: some View {
        ZStack {
            Background()
                .scaleEffect(viewRouter.isBlurred ? 1.1 : 1)
                .blur(radius: viewRouter.isBlurred ? 10 : 0, opaque: false)
                
                .animation(.easeInOut)
                .edgesIgnoringSafeArea(.all)
            VStack {
                //Menu button
                HStack {
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {Image("menu_24pt_white")} )
                        .padding([.top, .leading], 25.0)
                        .padding(.bottom, 20.0)
                        .shadow(color: shadowColor, radius: 3.5, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 2)
                    Spacer()
                }
                if (self.viewRouter.currentView == .details){
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

struct Background: View{
    
    let bgGradient = Gradient(colors: [Color("grad_clear_day_top"), Color("grad_clear_day_bottom")])
    let hillGradient = Gradient(colors: [Color("hill_clear_day_top"), Color("hill_clear_day_bottom")])
    
    var body: some View{
        
        LinearGradient(gradient: bgGradient, startPoint: /*@START_MENU_TOKEN@*/.top/*@END_MENU_TOKEN@*/, endPoint: UnitPoint(x: 0, y: 0.6)).edgesIgnoringSafeArea(.all)
        LinearGradient(gradient: hillGradient, startPoint: UnitPoint(x: 0, y: 0.6), endPoint: /*@START_MENU_TOKEN@*/.bottom/*@END_MENU_TOKEN@*/)
            .mask(
            VStack {
                Spacer()
                Image("hills")
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



