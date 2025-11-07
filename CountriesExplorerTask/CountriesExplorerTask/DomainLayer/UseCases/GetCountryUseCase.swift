//
//  GetCountryUseCase.swift
//  CountriesExplorerTask
//
//  Created by Marwa Attef on 07/11/2025.
//

import Foundation

protocol GetCountryUseCaseProtocol {
    func getCountry(by cca2: String) async throws -> CountryEntity
    func getCountries() async throws -> [CountryEntity]
    func getDefaultCountryAndSave(by cca2: String) async throws
}

class GetCountryUseCase: GetCountryUseCaseProtocol {
    private let repository: CountryRepositoryProtocol
    
    init(repository: CountryRepositoryProtocol) {
        self.repository = repository
    }
    
    func getCountry(by cca2: String) async throws -> CountryEntity {
        try await self.repository.getCountryLocaly(by: cca2)
    }
    
    func getCountries() async throws -> [CountryEntity] {
        try await self.repository.getAllCountriesLocaly()
    }
    
    func getDefaultCountryAndSave(by cca2: String) async throws {
        let countries: [CountryEntity] = try await self.repository.getCountries(by: cca2)
        guard let countryToBeSave =  countries.first else {
            return}
        try await self.repository.saveCountryLocaly(countryToBeSave)
    }
}
