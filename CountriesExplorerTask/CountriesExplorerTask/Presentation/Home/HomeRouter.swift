//
//  HomeRouter.swift
//  CountriesExplorerTask
//
//  Created by Marwa Attef on 07/11/2025.
//

protocol HomeRouterProtocol {
    func navigateToDetails(country: CountryEntity) -> CountryDetailsView
    func navigateToSearch(onCountrySaved: @escaping () -> Void) -> SearchCountryView
}

class HomeRouter: HomeRouterProtocol {
    
    private let homeComponent: HomeComponent
    
    init(homeComponent: HomeComponent) {
        self.homeComponent = homeComponent
    }
    
    func navigateToDetails(country: CountryEntity) -> CountryDetailsView {
        self.homeComponent.countryDetailsViewBuilder.countryDetailsView(country: country)
    }
    
    func navigateToSearch(onCountrySaved: @escaping () -> Void) -> SearchCountryView {
        self.homeComponent.searchCountryViewBuilder.searchCountryView(onCountrySaved: onCountrySaved)
    }
}
