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
}
