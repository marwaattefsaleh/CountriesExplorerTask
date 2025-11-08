//
//  MockGetCountryUseCase.swift
//  CountriesExplorerTask
//
//  Created by Marwa Attef on 08/11/2025.
//
@testable import CountriesExplorerTask
import Foundation

@MainActor
final class MockGetCountryUseCase: GetCountryUseCaseProtocol {
    
    // MARK: - Properties to control behavior
    var countryToReturn: CountryEntity?
    var countriesToReturn: [CountryEntity] = []
    var shouldThrowError: Bool = false
    var errorToThrow: Error = NSError(domain: "TestError", code: -1)
    
    // Track calls
    var getCountryCalledWith: String?
    var getCountriesCalled = false
    var getDefaultAndSaveCalledWith: String?
    var savedCountry: CountryEntity?
    
    // MARK: - Protocol methods
    
    func getCountry(by cca2: String) async throws -> CountryEntity {
        getCountryCalledWith = cca2
        if shouldThrowError { throw errorToThrow }
        guard let country = countryToReturn else {
            throw NSError(domain: "NotFound", code: 404)
        }
        return country
    }
    
    func getCountries() async throws -> [CountryEntity] {
        getCountriesCalled = true
        if shouldThrowError { throw errorToThrow }
        return countriesToReturn
    }
    
    func getDefaultCountryAndSave(by cca2: String) async throws {
        getDefaultAndSaveCalledWith = cca2
        if shouldThrowError { throw errorToThrow }
        guard let countryToSave = countriesToReturn.first else { return }
        savedCountry = countryToSave
    }
}
