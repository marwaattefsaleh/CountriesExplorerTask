//
//  SearchCountryViewModel.swift
//  CountriesExplorerTask
//
//  Created by Marwa Attef on 06/11/2025.
//

import Combine
import Foundation
import FirebaseCrashlytics
@MainActor
final class SearchCountryViewModel: ObservableObject {
    @Published var showToast: Bool = false
    @Published var isLoading: Bool = false
    @Published  var countryEntityList: [CountryEntity] = []
    
    private let networkMonitor: NetworkMonitorProtocol
    var toastMessage: String = ""
    private let searchCountriesUseCase: SearchCountriesUseCaseProtocol
    @Published var itemSelected: Bool = false
    
    init(searchCountriesUseCase: SearchCountriesUseCaseProtocol, networkMonitor: NetworkMonitorProtocol) {
        self.searchCountriesUseCase = searchCountriesUseCase
        self.networkMonitor = networkMonitor
    }
    
    func searchCountries(query: String) {
        guard !query.isEmpty else {
            return
        }
        isLoading = true
        Task {
            do {
                countryEntityList = try await searchCountriesUseCase.searchCountries(by: query)
                
            } catch {
                countryEntityList = []
                Crashlytics.crashlytics().record(error: error)
                toastMessage = error.localizedDescription
                showToast = true
            }
            isLoading = false
        }
    }
    
    func saveSelectedCountry(_ country: CountryEntity) {
        Task {
            do {
                try await self.searchCountriesUseCase.saveSelectedCountry(country)
                self.itemSelected = true
            } catch {
                toastMessage = error.localizedDescription
                showToast = true
                self.itemSelected = false
            }
            
        }
    }
}
