//
//  MenuView.swift
//  WeatherBoard-SwiftUI
//
//  Created by Justyn Henman on 08/11/2020.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        VStack{
            SearchBar(text: .constant(""))
                .padding(.top, -10)
            HStack {
                Text("History")
                    .font(Font.custom(Strings.font, size: 16))
                    .foregroundColor(.white)
                Spacer()
            }
            .padding(.vertical, 8)
                
            MenuButton()
            MenuButton()
            MenuButton()
            MenuButton()
        }
        .padding(.horizontal, 25.0)
    }
}

struct MenuButton: View{
    
    let bgGradient = Gradient(colors: [Color("button_clear_day_top"), Color("button_clear_day_bottom")])
    
    var body: some View{
        
        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
            ZStack {
                LinearGradient(gradient: bgGradient, startPoint: /*@START_MENU_TOKEN@*/.top/*@END_MENU_TOKEN@*/, endPoint: .bottom)
                HStack {
                    Text("Button")
                        .font(Font.custom(Strings.font, size: 20))
                        .foregroundColor(.white)
                        .padding(.leading)
                        .shadow(color: shadowColor, radius: 3.5, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 2)
                    Spacer()
                }
            }
            .frame(width: .infinity, height: 50, alignment: .center)
            .cornerRadius(12)
        })
        
    }
    
    
}

struct SearchBar: View {
    @Binding var text: String
 
    @State private var isEditing = false
 
    var body: some View {
        HStack {
 
            TextField("Search for a location", text: $text)
                .padding(.vertical, 12)
                .padding(.horizontal, 40)
                .background(Color(#colorLiteral(red: 0.5960784314, green: 0.5960784314, blue: 0.6156862745, alpha: 0.201171875)))
                .cornerRadius(12)
                //.padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }
        }
        .overlay(
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 15)
         
                if isEditing {
                    Button(action: {
                        self.isEditing = false
                        self.text = ""
                    }) {
                        Image(systemName: "multiply.circle.fill")
                            .foregroundColor(.gray)
                            .padding(.trailing, 8)
                    }
                }
            }
        )
        
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
            .preferredColorScheme(.dark)
    }
}
