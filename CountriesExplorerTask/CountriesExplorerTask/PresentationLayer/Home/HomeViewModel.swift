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
    @Published var showToast: Bool = false
    @Published var isLoading: Bool = false
    @Published  var countryEntityList: [CountryEntity] = []
    @Published var txtNumberSavedCountries: String = "Your selected countries 0/5"
    @Published var showAddButton: Bool = false
    @Published var currentCountryCode: String?
    private var cancellables = Set<AnyCancellable>()
    
    private let router: HomeRouterProtocol
    private let networkMonitor: NetworkMonitorProtocol
    private let getCountryUseCase: GetCountryUseCaseProtocol
    private let deleteCountryUseCase: DeleteCountryUseCaseProtocol
    private let locationManager: LocationManagerProtocol
    
    var toastMessage: String = ""
    
    init(deleteCountryUseCase: DeleteCountryUseCaseProtocol, getCountryUseCase: GetCountryUseCaseProtocol, router: HomeRouterProtocol, networkMonitor: NetworkMonitorProtocol, locationManager: LocationManagerProtocol) {
        self.deleteCountryUseCase = deleteCountryUseCase
        self.getCountryUseCase = getCountryUseCase
        self.router = router
        self.networkMonitor = networkMonitor
        self.locationManager = locationManager
    }
    
    func getUserCountryCode() {
        locationManager.currentCountryPublisher
            .receive(on: DispatchQueue.main).sink(receiveValue: { [weak self] countryCode in
                print("countryCode: \(countryCode ?? "")")
                if !(countryCode?.isEmpty ?? true) {
                    self?.getDefaultCountry(cca2: countryCode!)
                }
            }).store(in: &cancellables)
        locationManager.requestUserLocation()
    }
    
    func getDefaultCountry(cca2: String) {
        Task {
            do {
                try await self.getCountryUseCase.getDefaultCountryAndSave(by: cca2)
                self.getCountries()
            } catch {
                
            }
        }
    }
    
    func navigateToDetails(country: CountryEntity) -> CountryDetailsView {
        router.navigateToDetails(country: country)
    }
    func navigateToSearch() -> SearchCountryView {
        router.navigateToSearch(onCountrySaved: {
            self.getCountries()
        })
    }
    
    func getCountries() {
        isLoading = true
        Task {
            do {
                let countryEntityList = try await getCountryUseCase.getCountries()
                self.countryEntityList = countryEntityList
                txtNumberSavedCountries = "Your selected countries \(countryEntityList.count)/5"
                self.showAddButton = countryEntityList.count != 5
                if countryEntityList.isEmpty {
                    self.getUserCountryCode()
                }
            } catch {
                self.toastMessage = error.localizedDescription
                self.showToast = true
            }
            isLoading = false
        }
    }
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
}
