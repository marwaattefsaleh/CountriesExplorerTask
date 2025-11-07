//
//  CountryLocalDataSource.swift
//  CountriesExplorerTask
//
//  Created by Marwa Attef on 07/11/2025.
//

protocol CountryLocalDataSourceProtocol {
    func saveCountry(_ item: CountryDBModel) async throws
    func deleteCountry(by code: String) async throws
    func getAllCountries() async throws -> [CountryEntity]
    func getCountry(by cca2: String) async throws -> CountryEntity
}

class CountryLocalDataSource: CountryLocalDataSourceProtocol {
    private let actor: CountryModelActor

    init(actor: CountryModelActor) {
        self.actor = actor
    }
   
    func saveCountry(_ item: CountryDBModel) async throws {
        try await self.actor.saveOrUpdateCountry(item)
    }
    
    func deleteCountry(by code: String) async throws {
        try await self.actor.deleteCountry(by: code)
    }
    
    func getAllCountries() async throws -> [CountryEntity] {
        try await self.actor.getAllCountries()
    }
    
    func getCountry(by cca2: String) async throws -> CountryEntity {
      try await self.actor.getCountry(by: cca2)
    }
}
