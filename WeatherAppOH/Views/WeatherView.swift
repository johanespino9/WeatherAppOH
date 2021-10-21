//
//  WeatherView.swift
//  WeatherAppOH
//
//  Created by Johan Espino on 21/10/21.
//

import Foundation
import SwiftUI

struct WeatherView: View {
    @Binding var animationStarts: Bool
    var cityName: String
    var temperature: String
    var weather: String
    var icon: String
    
    
    var body: some View {
        VStack {
            Text(cityName)
                .font(.title)
                .bold()
            Text(temperature)
                .font(.title2)
                .bold()
            Text(weather)
            Text(icon)
                .font(.system(size: 60, weight: .bold, design: .default))
        }.frame(width: UIScreen.main.bounds.width * 0.9 , height: 200)
        .background(Color.white)
        .cornerRadius(10).shadow(radius: 10)
        .opacity(0.8)
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
        .animation(.easeIn).onAppear{
            animationStarts = true
        }
    }
}
