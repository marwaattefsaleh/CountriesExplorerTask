//
//  CountryDetailsComponent.swift
//  CountriesExplorerTask
//
//  Created by Marwa Attef on 06/11/2025.
//
import NeedleFoundation

protocol CountryDetailsDependency: Dependency {
    var networkMonitor: NetworkMonitorProtocol { get }
}

protocol CountryDetailsViewBuilder {
    func countryDetailsView(country: CountryEntity) -> CountryDetailsView
}

class CountryDetailsComponent: Component<CountryDetailsDependency>, CountryDetailsViewBuilder {

    var countryDetailsViewModel: CountryDetailsViewModel {
        let networkMonitor = self.networkMonitor
                return MainActor.assumeIsolated {
                    CountryDetailsViewModel(
                networkMonitor: networkMonitor
            )
        }
    }
    
    func countryDetailsView(country: CountryEntity) -> CountryDetailsView {
        CountryDetailsView(viewModel: self.countryDetailsViewModel, country: country)
    }
}
