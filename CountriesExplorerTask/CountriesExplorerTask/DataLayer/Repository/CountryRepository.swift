//
//  CountryRepository.swift
//  CountriesExplorerTask
//
//  Created by Marwa Attef on 07/11/2025.
//

import Foundation

protocol CountryRepositoryProtocol: AnyObject {
    func searchCountries(by name: String) async throws -> [CountryEntity]
    func saveCountryLocaly(_ item: CountryEntity) async throws
    func deleteCountryLocaly(by code: String) async throws
    func getAllCountriesLocaly() async throws -> [CountryEntity]
    func getCountryLocaly(by cca2: String) async throws -> CountryEntity
    func getCountries(by cca2: String) async throws -> [CountryEntity]
}

class CountryRepository: CountryRepositoryProtocol {
    private let remoteDataSource: CountryRemoteDataSourceProtocol
    private let localeDataSource: CountryLocalDataSourceProtocol
    
    init(remoteDataSource: CountryRemoteDataSourceProtocol, localeDataSource: CountryLocalDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
        self.localeDataSource = localeDataSource
    }
    
    func searchCountries(by name: String) async throws -> [CountryEntity] {
       let dtoList = try await self.remoteDataSource.searchCountries(by: name)
        return dtoList.map { $0.toEntity() }
    }
    
    func saveCountryLocaly(_ item: CountryEntity) async throws {
        try await self.localeDataSource.saveCountry(item.toDBModel())
    }
    
    func deleteCountryLocaly(by code: String) async throws {
        try await self.localeDataSource.deleteCountry(by: code)
    }
    
    func getAllCountriesLocaly() async throws -> [CountryEntity] {
        try await self.localeDataSource.getAllCountries()
    }
    
    func getCountryLocaly(by cca2: String) async throws -> CountryEntity {
        try await self.localeDataSource.getCountry(by: cca2)
    }
    
    func getCountries(by cca2: String) async throws -> [CountryEntity] {
        let dtoList = try await self.remoteDataSource.getCountries(by: cca2)
         return dtoList.map { $0.toEntity() }
    }
}
