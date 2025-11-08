//
//  SearchCountriesUseCase.swift
//  CountriesExplorerTask
//
//  Created by Marwa Attef on 07/11/2025.
//

import Foundation

protocol SearchCountriesUseCaseProtocol {
    func searchCountries(by name: String) async throws -> [CountryEntity]
    func saveSelectedCountry(_ country: CountryEntity) async throws
}

class SearchCountriesUseCase: SearchCountriesUseCaseProtocol {
    private let repository: CountryRepositoryProtocol
    
    init(repository: CountryRepositoryProtocol) {
        self.repository = repository
    }
  
    func searchCountries(by name: String) async throws -> [CountryEntity] {
        try await self.repository.searchCountries(by: name)
    }
    
    func saveSelectedCountry(_ country: CountryEntity) async throws {
        // 1️⃣ Fetch all countries
             let countries = try await self.repository.getAllCountriesLocaly()
             
             // 2️⃣ Check if already exists
             if countries.contains(where: { $0.cca2 == country.cca2 }) {
                 throw ValidationError.alreadyExist
             }
             
             // 3️⃣ Enforce the 5-country limit
        guard countries.count < Constants.maxSavedCountrySize else {
            throw ValidationError.limitExceeded(max: Constants.maxSavedCountrySize)
             }
             
             // 4️⃣ Save country via the actor
             try await self.repository.saveCountryLocaly(country)
    }
}
