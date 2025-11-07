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

    init() {
        // Register Needle providers
        registerProviderFactories()
        appComponent = AppComponent()

    }

    var body: some Scene {
        WindowGroup {
          appComponent.HomeViewBuilder.homeView
        }.modelContainer(appComponent.modelContainer)
    }
}
