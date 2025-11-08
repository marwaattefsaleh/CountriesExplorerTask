//
//  CountryRemoteDataSourceTests.swift
//  CountriesExplorerTask
//
//  Created by Marwa Attef on 08/11/2025.
//
import XCTest
@testable import CountriesExplorerTask
import Alamofire

// MARK: - CountryRemoteDataSource Tests
final class CountryRemoteDataSourceTests: XCTestCase {
    
    var mockService: MockNetworkService!
    var remoteDataSource: CountryRemoteDataSource!
    
    override func setUp() {
        super.setUp()
        mockService = MockNetworkService()
        remoteDataSource = CountryRemoteDataSource(networkService: mockService)
    }
    
    override func tearDown() {
        remoteDataSource = nil
        mockService = nil
        super.tearDown()
    }
    
    func testSearchCountries_Success() async throws {
        let countryDTO = CountryDTO(
            name: "Egypt",
            topLevelDomain: [".eg"],
            alpha2Code: "EG",
            alpha3Code: "EGY",
            callingCodes: ["20"],
            capital: "Cairo",
            altSpellings: nil,
            subregion: "Northern Africa",
            region: "Africa",
            population: 100_000_000,
            latlng: [26.0, 30.0],
            demonym: nil,
            area: 1000,
            gini: nil,
            timezones: nil,
            borders: nil,
            nativeName: "مصر",
            numericCode: nil,
            flags: FlagDTO(svg: "", png: "https://flag.png"),
            currencies: [CurrencyDTO(code: "EGP", name: "Egyptian Pound", symbol: "£")],
            languages: [LanguageDTO(iso639_1: "ar", iso639_2: "ara", name: "Arabic", nativeName: "العربية")],
            translations: nil,
            flag: nil,
            regionalBlocs: nil,
            cioc: nil,
            independent: true
        )
        
        mockService.resultToReturn = .success(try JSONEncoder().encode([countryDTO]))
        
        let result = try await remoteDataSource.searchCountries(by: "Egypt")
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.name, "Egypt")
        XCTAssertEqual(result.first?.alpha2Code, "EG")
    }
    
    func testSearchCountries_Failure() async {
        mockService.resultToReturn = .failure(NetworkError.noInternet)
        
        await XCTAssertThrowsErrorAsync(
            try await remoteDataSource.searchCountries(by: "Egypt")
        ) { error in
            XCTAssertTrue(error is NetworkError)
            if let netError = error as? NetworkError {
                XCTAssertEqual(netError, .noInternet)
            }
        }
    }
    
    func testGetCountries_Success() async throws {
        let countryDTO = CountryDTO(
            name: "Egypt",
            topLevelDomain: [".eg"],
            alpha2Code: "EG",
            alpha3Code: "EGY",
            callingCodes: ["20"],
            capital: "Cairo",
            altSpellings: nil,
            subregion: "Northern Africa",
            region: "Africa",
            population: 100_000_000,
            latlng: [26.0, 30.0],
            demonym: nil,
            area: 1000,
            gini: nil,
            timezones: nil,
            borders: nil,
            nativeName: "مصر",
            numericCode: nil,
            flags: FlagDTO(svg: "", png: "https://flag.png"),
            currencies: [CurrencyDTO(code: "EGP", name: "Egyptian Pound", symbol: "£")],
            languages: [LanguageDTO(iso639_1: "ar", iso639_2: "ara", name: "Arabic", nativeName: "العربية")],
            translations: nil,
            flag: nil,
            regionalBlocs: nil,
            cioc: nil,
            independent: true
        )
        
        mockService.resultToReturn = .success(try JSONEncoder().encode([countryDTO]))
        
        let result = try await remoteDataSource.getCountries(by: "EG")
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.name, "Egypt")
        XCTAssertEqual(result.first?.alpha2Code, "EG")
    }
    
    func testGetCountries_Failure() async {
        mockService.resultToReturn = .failure(NetworkError.notFound)
        
        await XCTAssertThrowsErrorAsync(
            try await remoteDataSource.getCountries(by: "EG")
        ) { error in
            XCTAssertTrue(error is NetworkError)
            if let netError = error as? NetworkError {
                XCTAssertEqual(netError, .notFound)
            }
        }
    }
}
