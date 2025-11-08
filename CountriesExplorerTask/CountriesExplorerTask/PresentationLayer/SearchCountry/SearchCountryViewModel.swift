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
    
    var toastMessage: String = ""
    private let searchCountriesUseCase: SearchCountriesUseCaseProtocol
    @Published var itemSelected: Bool = false
    
    init(searchCountriesUseCase: SearchCountriesUseCaseProtocol) {
        self.searchCountriesUseCase = searchCountriesUseCase
    }
    func performSearch(query: String) async throws -> [CountryEntity] {
        try await searchCountriesUseCase.searchCountries(by: query)
    }
    
    func performSaveCountry(_ country: CountryEntity) async throws {
        try await searchCountriesUseCase.saveSelectedCountry(country)
    }
    
    func searchCountries(query: String) {
        guard !query.isEmpty else {
            return
        }
        isLoading = true
        Task {
            do {
                countryEntityList = try await self.performSearch(query: query)
                
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
                try await self.performSaveCountry(country)
                self.itemSelected = true
            } catch {
                toastMessage = error.localizedDescription
                showToast = true
                self.itemSelected = false
            }
            
        }
    }
}
