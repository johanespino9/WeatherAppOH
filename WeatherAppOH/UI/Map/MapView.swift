//
//  ContentView.swift
//  WeatherAppOH
//
//  Created by Johan Espino on 20/10/21.
//
import MapKit
import SwiftUI

struct MapView: View {
    @ObservedObject var viewModel = MapViewModel()
    @State private var cityCoordinate = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -12.01835655246863, longitude: -77.05235925574131), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    @State var cityName: String = ""
    @State var animationStarts: Bool = false
    @State var showWeather: Bool = false
    @State var showAlert: Bool = false
    func searchCity() {
        viewModel.getWeatherByCity(cityName: self.cityName) { success in
            if success {
                showWeather = true
                cityCoordinate = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: viewModel.weatherObj?.latitude ?? 0.0, longitude: viewModel.weatherObj?.longitude ?? 0.0), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
            } else {
                showWeather = false
                showAlert = true
            }
        }
    }
    
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $cityCoordinate)
            VStack {
                CitySearchHeader(cityName: $cityName){
                    searchCity()
                }
                Spacer()
                if showWeather {
                    WeatherView(animationStarts: $animationStarts, cityName: viewModel.weatherObj?.cityName ?? "", temperature: "\(Int(viewModel.weatherObj?.temperature ?? 0.0))º", weather: viewModel.weatherObj?.description ?? "", icon: viewModel.weatherObj?.iconName ?? "")
                }
            }
            Text("")
                .alert(isPresented: self.$showAlert){
                    Alert(title: Text("Ciudad no encontrada"), message: Text("Por favor, ingrese un nombre válido de ciudad"), dismissButton: .default(Text("Entendido")))
                }
            
            
        }
        
    }
}




