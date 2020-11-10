//
//  ContentView.swift
//  WeatherBoard-SwiftUI
//
//  Created by Justyn Henman on 05/11/2020.
//

import SwiftUI
import Combine

let shadowColor = Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.2)


//MARK: - Root View

struct MainView: View {
    
    @ObservedObject var viewManager = ViewManager()
    
    //view
    var body: some View {
        ZStack {
            Background(viewManager: viewManager)
            VStack {
                MenuBar(viewManager: viewManager)
                if(viewManager.menuShown){
                    MenuView()
                }else if(self.viewManager.currentView == .details){
                    DetailsView()
                }else{
                    WeatherView()
                }
                Spacer()
                NavBar(viewManager: viewManager)
            }.animation(.easeInOut(duration: 0.2))
        }
        
    }
}

//MARK: - Menu Bar

struct MenuBar: View {
    
    @ObservedObject var viewManager = ViewManager()
    
    let cancelIcon = Image(Constants.menuBar.cancel)
    let locationIcon = Image(Constants.menuBar.location)
    let menuIcon = Image(Constants.menuBar.menu)
    
    let titleText = Text("WeatherBoard")
        .font(Font.custom(Constants.font, size: 24))
    
    var body: some View{
        HStack{
            Button(action: {
                viewManager.menuShown.toggle()
            }, label: {viewManager.menuShown ? cancelIcon : menuIcon} )
                .shadow(color: shadowColor, radius: 3.5, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 2)
            Spacer()
            titleText
                .opacity(viewManager.menuShown ? 1 : 0)
            Spacer()
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {viewManager.menuShown ? locationIcon : nil} )
                .shadow(color: shadowColor, radius: 3.5, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 2)
            
        }
        .padding(.horizontal, 30.0)
        .padding(.vertical, 25)
        
    }
    
    
    
    
    
}


//MARK: - Background

struct Background: View{
    
    @ObservedObject var viewManager = ViewManager()

    let bgGradientView = GradientView(isHill: false)
    let hillGradientView = GradientView(isHill: true)
    
    func setGradients(condition: String){
        bgGradientView.setGradient(condition: condition)
        hillGradientView.setGradient(condition: condition)
    }
    
    var body: some View{
        ZStack {
            Group {
                bgGradientView
                hillGradientView
                    .mask(
                    VStack {
                        Spacer()
                        Image("hills")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    })
                    .edgesIgnoringSafeArea(.vertical)
            }
            .blur(radius: viewManager.isBlurred && !viewManager.menuShown ? 40 : 0)
            .scaleEffect(x: viewManager.isBlurred && !viewManager.menuShown ? 1.3 : 1, y: viewManager.isBlurred && !viewManager.menuShown ? 1.1 : 1, anchor: .center)
            .saturation(viewManager.isBlurred && !viewManager.menuShown ? 1.2 : 1)
            .animation(.easeInOut(duration: 0.2))
            Rectangle()
                .foregroundColor(viewManager.isBlurred && !viewManager.menuShown ? Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.1) : .clear)
        }
        .edgesIgnoringSafeArea(.all)
        .onChange(of: viewManager.currentGradient, perform: { value in
            setGradients(condition: viewManager.currentGradient)
        })
        .onChange(of: viewManager.menuShown, perform: { menuShown in
            if menuShown{
                withAnimation(.spring()) {
                    setGradients(condition: "menu")
                }
            }else{
                withAnimation(.spring()) {
                    print("Current viewmanager is \(viewManager.currentGradient)")
                    setGradients(condition: viewManager.currentGradient)
                }
            }
        })
    }
    
    
    
}



//MARK: - GradientView
struct GradientView: View {
    
    var isHill: Bool
    
    var gradType: String{
        return isHill ? "hill" : "grad"
    }
    
    //makes 2 identical gradients
    @State private var gradientA: [Color] = [.black, .black]
    @State private var gradientB: [Color] = [.black, .black]
    
    @State var firstPlane: Bool = true
    
    
    func setGradient(condition: String) {
        
        print("CONDITION IS \(condition)")
        
        let gradient : [Color] = [Color("\(gradType)_\(condition)_top"),
                                  Color("\(gradType)_\(condition)_bottom")]
        
        print(gradient)
        
        firstPlane ? (gradientB = gradient) : (gradientA = gradient)
        firstPlane = !firstPlane
        
        print("grad sset")
        
        print("GRADIENT A IS \(gradientA)")
        print("GRADIENT B IS \(gradientB)")
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: self.gradientA),
                                     startPoint: isHill ? UnitPoint(x: 0.5, y: 0.6) : .top,
                                     endPoint: isHill ? .bottom : UnitPoint(x: 0.5, y: 0.8))
                )
            Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: self.gradientB),
                                     startPoint: UnitPoint(x: 0, y: 0),
                                     endPoint: UnitPoint(x: 0, y: 1))
                )
                .opacity(self.firstPlane ? 0 : 1)
        }
    }
    
}


//MARK: - Navigation Bar

struct NavBar: View{
    
    @ObservedObject var viewManager: ViewManager
    
    let navFont = Font.custom(Constants.font, size: 16)
    let shadowColor = Color(red: 1.0, green: 0.0, blue: 0.0, opacity: 0.3)
    
    var body: some View {
    
        HStack{
            if viewManager.menuShown{
                Spacer()
            }else{
                Spacer()
                Button(action: {viewManager.currentView = .today}) {
                    Text("TODAY")
                        .foregroundColor(.white)
                        .opacity(viewManager.currentView == .today ? 1 : 0.5)
                        .font(navFont)
                        .frame(width: 93.5, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .shadow(color: shadowColor, radius: 3.5, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 2)
                }
                Spacer(minLength: 23)
                Button(action: {viewManager.currentView = .tomorrow}) {
                    Text("TOMORROW")
                        .foregroundColor(.white)
                        .opacity(viewManager.currentView == .tomorrow ? 1 : 0.5)
                        .font(navFont)
                        .frame(width: 93.5, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .shadow(color: shadowColor, radius: 3.5, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 2)
                }
                Spacer(minLength: 23)
                Button(action: {viewManager.currentView = .details}) {
                    Text("MORE")
                        .foregroundColor(.white)
                        .opacity(viewManager.currentView == .details ? 1 : 0.5)
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



