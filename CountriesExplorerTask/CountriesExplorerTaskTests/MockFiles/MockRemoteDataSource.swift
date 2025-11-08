//
//  MockRemoteDataSource.swift
//  CountriesExplorerTask
//
//  Created by Marwa Attef on 08/11/2025.
//
import XCTest
@testable import CountriesExplorerTask

// MARK: - Mocks
final class MockRemoteDataSource: CountryRemoteDataSourceProtocol {
    var searchResult: [CountryDTO] = []
    var getCountriesResult: [CountryDTO] = []
    var shouldThrow = false
    var errorToThrow: Error = NSError(domain: "Test", code: 0)

    func searchCountries(by name: String) async throws -> [CountryDTO] {
        if shouldThrow { throw errorToThrow }
        return searchResult
    }

    func getCountries(by cca2: String) async throws -> [CountryDTO] {
        if shouldThrow { throw errorToThrow }
        return getCountriesResult
    }
}
