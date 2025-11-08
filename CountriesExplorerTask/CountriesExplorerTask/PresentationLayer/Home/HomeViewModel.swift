//
//  HomeViewModel.swift
//  CountriesExplorerTask
//
//  Created by Marwa Attef on 06/11/2025.
//

import Combine
import Foundation
import FirebaseCrashlytics
@MainActor
final class HomeViewModel: ObservableObject {
    // MARK: - Published UI State
    @Published var showToast: Bool = false
    @Published var isLoading: Bool = false
    @Published  var countryEntityList: [CountryEntity] = []
    @Published var txtNumberSavedCountries: String = "Your selected countries 0/5"
    @Published var showAddButton: Bool = false
    @Published var currentCountryCode: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Dependencies
    private let router: HomeRouterProtocol
    private let getCountryUseCase: GetCountryUseCaseProtocol
    private let deleteCountryUseCase: DeleteCountryUseCaseProtocol
    private let locationManager: LocationManagerProtocol
    
    var toastMessage: String = ""
    
    // MARK: - Init
    init(deleteCountryUseCase: DeleteCountryUseCaseProtocol, getCountryUseCase: GetCountryUseCaseProtocol, router: HomeRouterProtocol, locationManager: LocationManagerProtocol) {
        self.deleteCountryUseCase = deleteCountryUseCase
        self.getCountryUseCase = getCountryUseCase
        self.router = router
        self.locationManager = locationManager
    }
    
    func observeLocation() {
        locationManager.currentCountryPublisher
            .receive(on: DispatchQueue.main).sink(receiveValue: { [weak self] countryCode in
                print("countryCode: \(countryCode ?? "")")
                guard let self = self, let code = countryCode, !code.isEmpty else { return }
                Task {
                    await self.fetchAndSaveDefaultCountry(cca2: code)
                }
            }).store(in: &cancellables)
    }
    
    func requestUserLocation() {
        locationManager.requestUserLocation()
    }
    
    func fetchAndSaveDefaultCountry(cca2: String) async {
        do {
            try await self.getCountryUseCase.getDefaultCountryAndSave(by: cca2)
            await self.getCountriesAsync()
        } catch {
            self.toastMessage = error.localizedDescription
            self.showToast = true
        }
        
    }
    // MARK: - Fetch Countries
    func fetchCountries() async throws -> [CountryEntity] {
        try await getCountryUseCase.getCountries()
    }
    
    func getCountries() {
        isLoading = true
        Task {
            await getCountriesAsync()
        }
    }
    
    func getCountriesAsync() async {
            do {
                let countryEntityList = try await fetchCountries()
                self.countryEntityList = countryEntityList
                txtNumberSavedCountries = "Your selected countries \(countryEntityList.count)/5"
                self.showAddButton = countryEntityList.count != 5
                if countryEntityList.isEmpty {
                    self.observeLocation()
                    self.requestUserLocation()
                }
            } catch {
                self.toastMessage = error.localizedDescription
                self.showToast = true
            }
            isLoading = false
    }
    
    // MARK: - Delete Country
    func deleteCountry(by cca2: String) {
        Task {
            do {
                try await self.deleteCountryUseCase.deleteCountry(by: cca2)
                countryEntityList.removeAll(where: {$0.cca2 == cca2})
                txtNumberSavedCountries = "Your selected countries \(countryEntityList.count)/5"
                self.showAddButton = countryEntityList.count != 5
                
            } catch {
                self.toastMessage = error.localizedDescription
                self.showToast = true
            }
        }
    }
    
    // MARK: - Navigation
    func navigateToDetails(country: CountryEntity) -> CountryDetailsView {
        router.navigateToDetails(country: country)
    }
    
    func navigateToSearch() -> SearchCountryView {
        router.navigateToSearch(onCountrySaved: {
            self.getCountries()
        })
    }
}
