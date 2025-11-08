//
//  MockHomeRouter.swift
//  CountriesExplorerTask
//
//  Created by Marwa Attef on 08/11/2025.
//
import SwiftUI
@testable import CountriesExplorerTask

final class MockHomeRouter: @preconcurrency HomeRouterProtocol {
    
    // Track navigation calls
    var didNavigateToDetails = false
    var didNavigateToSearch = false
    var passedCountry: CountryEntity?
    var onCountrySavedClosure: (() -> Void)?
    
    @MainActor
    func navigateToDetails(country: CountryEntity) -> CountryDetailsView {
        didNavigateToDetails = true
        passedCountry = country
        // Use a mock ViewModel to avoid forcing unwrapping
        let viewModel = CountryDetailsViewModel()
        return CountryDetailsView(viewModel: viewModel, country: country)
    }
    
    @MainActor
    func navigateToSearch(onCountrySaved: @escaping () -> Void) -> SearchCountryView {
        didNavigateToSearch = true
        onCountrySavedClosure = onCountrySaved
        // Use a mock ViewModel
        let mockUseCase = MockSearchCountriesUseCase()
        let viewModel = SearchCountryViewModel(searchCountriesUseCase: mockUseCase)
        return SearchCountryView(viewModel: viewModel, onCountrySaved: onCountrySaved)
    }
}
