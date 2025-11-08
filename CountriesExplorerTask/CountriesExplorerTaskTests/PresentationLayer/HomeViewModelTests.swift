//
//  HomeViewModelTests.swift
//  CountriesExplorerTask
//
//  Created by Marwa Attef on 08/11/2025.
//
//
//  HomeViewModelTests.swift
//  CountriesExplorerTaskTests
//
//  Created by Marwa Attef on 08/11/2025.
//
import XCTest
import Combine
@testable import CountriesExplorerTask

// MARK: - HomeViewModel Tests
@MainActor
final class HomeViewModelTests: XCTestCase {

    var viewModel: HomeViewModel!
    var getCountryUseCase: MockGetCountryUseCase!
    var deleteCountryUseCase: MockDeleteCountryUseCase!
    var router: MockHomeRouter!
    var locationManager: MockLocationManager!

    override func setUp() async throws {
        getCountryUseCase = MockGetCountryUseCase()
        deleteCountryUseCase = MockDeleteCountryUseCase()
        router = MockHomeRouter()
        locationManager = MockLocationManager()

        viewModel = HomeViewModel(
            deleteCountryUseCase: deleteCountryUseCase,
            getCountryUseCase: getCountryUseCase,
            router: router,
            locationManager: locationManager
        )
    }

    override func tearDown() async throws {
        viewModel = nil
        getCountryUseCase = nil
        deleteCountryUseCase = nil
        router = nil
        locationManager = nil
    }

    // MARK: - Tests

    func testFetchCountriesUpdatesUI() async {
        let country = CountryEntity(name: "Egypt", capitalName: "Cairo", flag: nil, currency: nil, cca2: "EG")
        getCountryUseCase.countriesToReturn = [country]

        await viewModel.getCountriesAsync()

        XCTAssertEqual(viewModel.countryEntityList.count, 1)
        XCTAssertEqual(viewModel.txtNumberSavedCountries, "Your selected countries 1/5")
        XCTAssertTrue(viewModel.showAddButton)
        XCTAssertFalse(viewModel.showToast)
    }

    func testFetchCountriesHandlesEmptyAndRequestsLocation() async {
        getCountryUseCase.countriesToReturn = []

        await viewModel.getCountriesAsync()

        XCTAssertTrue(locationManager.requestLocationCalled)
    }

    func testFetchCountriesHandlesError() async {
        getCountryUseCase.shouldThrowError = true

        await viewModel.getCountriesAsync()

        XCTAssertTrue(viewModel.showToast)
        XCTAssertEqual(viewModel.toastMessage, getCountryUseCase.errorToThrow.localizedDescription)
    }

    func testDeleteCountryUpdatesUI() async {
        let country = CountryEntity(name: "Egypt", capitalName: "Cairo", flag: nil, currency: nil, cca2: "EG")
        viewModel.countryEntityList = [country]

        viewModel.deleteCountry(by: "EG")
        try? await Task.sleep(nanoseconds: 100_000_000)

        XCTAssertTrue(viewModel.countryEntityList.isEmpty)
        XCTAssertEqual(viewModel.txtNumberSavedCountries, "Your selected countries 0/5")
        XCTAssertTrue(viewModel.showAddButton)
        XCTAssertEqual(deleteCountryUseCase.deletedCca2, "EG")
    }

    func testDeleteCountryHandlesError() async {
        deleteCountryUseCase.shouldThrowError = true

        viewModel.deleteCountry(by: "EG")
        try? await Task.sleep(nanoseconds: 100_000_000)

        XCTAssertTrue(viewModel.showToast)
        XCTAssertEqual(viewModel.toastMessage, deleteCountryUseCase.errorToThrow.localizedDescription)
    }

    func testNavigationToDetails() async {
        let country = CountryEntity(name: "Egypt", capitalName: "Cairo", flag: nil, currency: nil, cca2: "EG")

        _ = viewModel.navigateToDetails(country: country)

        XCTAssertTrue(router.didNavigateToDetails)
        XCTAssertEqual(router.passedCountry?.cca2, "EG")
    }

    func testNavigationToSearchCallsClosure() async {
        _ = viewModel.navigateToSearch()

        XCTAssertTrue(router.didNavigateToSearch)
        XCTAssertNotNil(router.onCountrySavedClosure)
    }

    func testFetchAndSaveDefaultCountryUpdatesUI() async {
        let country = CountryEntity(name: "Egypt", capitalName: "Cairo", flag: nil, currency: nil, cca2: "EG")
        getCountryUseCase.countriesToReturn = [country]

        await viewModel.fetchAndSaveDefaultCountry(cca2: "EG")

        XCTAssertEqual(getCountryUseCase.getDefaultAndSaveCalledWith, "EG")
        XCTAssertEqual(getCountryUseCase.savedCountry?.cca2, "EG")
    }

    func testFetchAndSaveDefaultCountryHandlesError() async {
        getCountryUseCase.shouldThrowError = true

        await viewModel.fetchAndSaveDefaultCountry(cca2: "EG")

        XCTAssertTrue(viewModel.showToast)
        XCTAssertEqual(viewModel.toastMessage, getCountryUseCase.errorToThrow.localizedDescription)
    }
}
