//
//  SearchCountryComponent.swift
//  CountriesExplorerTask
//
//  Created by Marwa Attef on 06/11/2025.
//
import NeedleFoundation

protocol SearchCountryDependency: Dependency {
    var searchCountriesUseCase: SearchCountriesUseCaseProtocol {get}

}

protocol SearchCountryViewBuilder {
    func searchCountryView(onCountrySaved: @escaping () -> Void) -> SearchCountryView
}

class SearchCountryComponent: Component<SearchCountryDependency>, SearchCountryViewBuilder {

    var searchCountryViewModel: SearchCountryViewModel {
                return MainActor.assumeIsolated {
                    SearchCountryViewModel(
                        searchCountriesUseCase: self.searchCountriesUseCase
            )
        }
    }
    
    func searchCountryView(onCountrySaved: @escaping () -> Void) -> SearchCountryView {
        SearchCountryView(viewModel: self.searchCountryViewModel, onCountrySaved: onCountrySaved)
    }
}
