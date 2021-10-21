//
//  CitySearchHeader.swift
//  WeatherAppOH
//
//  Created by Johan Espino on 21/10/21.
//

import Foundation
import SwiftUI

struct CitySearchHeader: View {
    @Binding var cityName: String
    @State var isFocused: Bool = true
    var searchCity: () -> ()
    
    var body: some View {
        VStack {
            HStack {
                TextField("Ingrese una ciudad", text: $cityName)
                    
                    .padding()
                    
                Button {
                    searchCity()
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
                } label: {
                    Text("Buscar")
                }.padding()
                
            }
            
        }.frame(width: UIScreen.main.bounds.width * 0.9 , height: 50)
        .background(Color.white)
        .cornerRadius(10).shadow(radius: 10)
        .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
        .opacity(0.9)
    }
}
