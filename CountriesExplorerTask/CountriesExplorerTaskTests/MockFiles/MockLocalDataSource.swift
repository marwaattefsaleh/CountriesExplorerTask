//
//  MockLocalDataSource.swift
//  CountriesExplorerTask
//
//  Created by Marwa Attef on 08/11/2025.
//
import XCTest
@testable import CountriesExplorerTask

final class MockLocalDataSource: CountryLocalDataSourceProtocol {
    var savedCountries: [CountryEntity] = []
    var shouldThrow = false
    var errorToThrow: Error = NSError(domain: "Test", code: 0)

    func saveCountry(_ item: CountryDBModel) async throws {
        if shouldThrow { throw errorToThrow }
        savedCountries.append(item.toEntity())
    }

    func deleteCountry(by code: String) async throws {
        if shouldThrow { throw errorToThrow }
        savedCountries.removeAll { $0.cca2 == code }
    }

    func getAllCountries() async throws -> [CountryEntity] {
        if shouldThrow { throw errorToThrow }
        return savedCountries
    }

    func getCountry(by cca2: String) async throws -> CountryEntity {
        if shouldThrow { throw errorToThrow }
        guard let country = savedCountries.first(where: { $0.cca2 == cca2 }) else {
            throw NSError(domain: "Test", code: 404)
        }
        return country
    }
}

