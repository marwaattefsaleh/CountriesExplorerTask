//
//  SearchCountryComponent.swift
//  CountriesExplorerTask
//
//  Created by Marwa Attef on 06/11/2025.
//
import NeedleFoundation

protocol SearchCountryDependency: Dependency {
    var networkMonitor: NetworkMonitorProtocol { get }
    var searchCountriesUseCase: SearchCountriesUseCaseProtocol {get}

}

protocol SearchCountryViewBuilder {
    func searchCountryView(onCountrySaved: @escaping () -> Void) -> SearchCountryView
}

class SearchCountryComponent: Component<SearchCountryDependency>, SearchCountryViewBuilder {

    var searchCountryViewModel: SearchCountryViewModel {
        let networkMonitor = self.networkMonitor
                return MainActor.assumeIsolated {
                    SearchCountryViewModel(
                        searchCountriesUseCase: self.searchCountriesUseCase, networkMonitor: networkMonitor
            )
        }
    }
    
    func searchCountryView(onCountrySaved: @escaping () -> Void) -> SearchCountryView {
        SearchCountryView(viewModel: self.searchCountryViewModel, onCountrySaved: onCountrySaved)
    }
}
