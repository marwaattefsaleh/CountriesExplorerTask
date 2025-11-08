//
//  CountryRepositoryTests.swift
//  CountriesExplorerTask
//
//  Created by Marwa Attef on 08/11/2025.
//

import XCTest
@testable import CountriesExplorerTask

// MARK: - CountryRepository Tests
final class CountryRepositoryTests: XCTestCase {

    var remoteDataSource: MockRemoteDataSource!
    var localDataSource: MockLocalDataSource!
    var repository: CountryRepository!

    override func setUp() {
        super.setUp()
        remoteDataSource = MockRemoteDataSource()
        localDataSource = MockLocalDataSource()
        repository = CountryRepository(remoteDataSource: remoteDataSource, localeDataSource: localDataSource)
    }

    override func tearDown() {
        repository = nil
        remoteDataSource = nil
        localDataSource = nil
        super.tearDown()
    }

    func testSearchCountries_ReturnsEntities() async throws {
        let dto = CountryDTO(name: "Egypt", topLevelDomain: nil, alpha2Code: "EG", alpha3Code: "EGY",
                             callingCodes: nil, capital: "Cairo", altSpellings: nil, subregion: nil, region: "Africa",
                             population: 100000, latlng: nil, demonym: nil, area: nil, gini: nil, timezones: nil,
                             borders: nil, nativeName: nil, numericCode: nil, flags: nil, currencies: nil,
                             languages: nil, translations: nil, flag: nil, regionalBlocs: nil, cioc: nil, independent: nil)
        remoteDataSource.searchResult = [dto]

        let result = try await repository.searchCountries(by: "Egypt")
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.name, "Egypt")
    }

    func testGetCountries_ReturnsEntities() async throws {
        let dto = CountryDTO(name: "Egypt", topLevelDomain: nil, alpha2Code: "EG", alpha3Code: "EGY",
                             callingCodes: nil, capital: "Cairo", altSpellings: nil, subregion: nil, region: "Africa",
                             population: 100000, latlng: nil, demonym: nil, area: nil, gini: nil, timezones: nil,
                             borders: nil, nativeName: nil, numericCode: nil, flags: nil, currencies: nil,
                             languages: nil, translations: nil, flag: nil, regionalBlocs: nil, cioc: nil, independent: nil)
        remoteDataSource.getCountriesResult = [dto]

        let result = try await repository.getCountries(by: "EG")
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.cca2, "EG")
    }

    func testSaveCountryLocaly_AddsCountry() async throws {
        let entity = CountryEntity(name: "Egypt", capitalName: "Cairo", flag: nil, currency: nil, cca2: "EG",
                                   population: 100000, region: "Africa", languages: nil, coordinates: nil)

        try await repository.saveCountryLocaly(entity)

        let all = try await repository.getAllCountriesLocaly()
        XCTAssertEqual(all.count, 1)
        XCTAssertEqual(all.first?.cca2, "EG")
    }

    func testDeleteCountryLocaly_RemovesCountry() async throws {
        let entity = CountryEntity(name: "Egypt", capitalName: "Cairo", flag: nil, currency: nil, cca2: "EG",
                                   population: 100000, region: "Africa", languages: nil, coordinates: nil)
        try await repository.saveCountryLocaly(entity)

        try await repository.deleteCountryLocaly(by: "EG")
        let all = try await repository.getAllCountriesLocaly()
        XCTAssertEqual(all.count, 0)
    }

    func testGetCountryLocaly_ReturnsCountry() async throws {
        let entity = CountryEntity(name: "Egypt", capitalName: "Cairo", flag: nil, currency: nil, cca2: "EG",
                                   population: 100000, region: "Africa", languages: nil, coordinates: nil)
        try await repository.saveCountryLocaly(entity)

        let result = try await repository.getCountryLocaly(by: "EG")
        XCTAssertEqual(result.name, "Egypt")
    }

    func testGetAllCountriesLocaly_ReturnsAll() async throws {
        let entity1 = CountryEntity(name: "Egypt", capitalName: "Cairo", flag: nil, currency: nil, cca2: "EG",
                                   population: 100000, region: "Africa", languages: nil, coordinates: nil)
        let entity2 = CountryEntity(name: "France", capitalName: "Paris", flag: nil, currency: nil, cca2: "FR",
                                   population: 67000000, region: "Europe", languages: nil, coordinates: nil)

        try await repository.saveCountryLocaly(entity1)
        try await repository.saveCountryLocaly(entity2)

        let all = try await repository.getAllCountriesLocaly()
        XCTAssertEqual(all.count, 2)
    }
}
