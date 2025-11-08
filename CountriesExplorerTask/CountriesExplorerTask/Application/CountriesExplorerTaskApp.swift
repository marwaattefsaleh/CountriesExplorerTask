//
//  CountriesExplorerTaskApp.swift
//  CountriesExplorerTask
//
//  Created by Marwa Attef on 06/11/2025.
//

import SwiftUI
import SwiftData

@main
struct CountriesExplorerTaskApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var appComponent: AppComponent!
    var homeView: HomeView!

    init() {
        // Register Needle providers
        registerProviderFactories()
        appComponent = AppComponent()
        if CommandLine.arguments.contains("--UITestMode--details") {
            let testCountry = CountryEntity(name: "Egypt", capitalName: "Cairo", flag: nil, currency: "EGP", cca2: "EG", population: 100_000_000, region: "Africa", languages: "Arabic", coordinates: "30.033° N, 31.233° E")
            let mockVM = HomeViewModel(deleteCountryUseCase: MockDeleteCountryUseCase(), getCountryUseCase: MockGetCountryUseCase(), router: MockHomeRouter(), locationManager: MockLocationManager())
            mockVM.countryEntityList = [testCountry]
            homeView = HomeView(viewModel: mockVM)
        } else {
            homeView =  appComponent.HomeViewBuilder.homeView

        }
    }

    var body: some Scene {
        WindowGroup {
            homeView
        }.modelContainer(appComponent.modelContainer)
    }
}
