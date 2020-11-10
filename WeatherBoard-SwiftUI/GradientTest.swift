//
//  GradientTest.swift
//  WeatherBoard-SwiftUI
//
//  Created by Justyn Henman on 10/11/2020.
//

import SwiftUI

extension Color {
    static func random()->Color {
        let r = Double.random(in: 0 ... 1)
        let g = Double.random(in: 0 ... 1)
        let b = Double.random(in: 0 ... 1)
        return Color(red: r, green: g, blue: b)
    }
}

struct GradientTest: View {
    @State private var gradientA: [Color] = [.red, .purple]
    @State private var gradientB: [Color] = [.red, .purple]
    
    @State private var firstPlane: Bool = true
    
    func setGradient(gradient: [Color]) {
        firstPlane ? (gradientB = gradient) : (gradientA = gradient)
        firstPlane = !firstPlane
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(LinearGradient(gradient: Gradient(colors: self.gradientA), startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 0, y: 1)))
            RoundedRectangle(cornerRadius: 8)
                .fill(LinearGradient(gradient: Gradient(colors: self.gradientB), startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 0, y: 1)))
                .opacity(self.firstPlane ? 0 : 1)
        }
        .frame(width: 256, height: 256)
        .onTapGesture {
            withAnimation(.spring()) {
                self.setGradient(gradient: [Color.random(), Color.random()])
            }
        }
    }
}
struct GradientTest_Previews: PreviewProvider {
    static var previews: some View {
        GradientTest()
    }
}
