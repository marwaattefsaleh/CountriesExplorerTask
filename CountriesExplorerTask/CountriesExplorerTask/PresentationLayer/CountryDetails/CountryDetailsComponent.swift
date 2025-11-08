//
//  CountryDetailsComponent.swift
//  CountriesExplorerTask
//
//  Created by Marwa Attef on 06/11/2025.
//
import NeedleFoundation

protocol CountryDetailsDependency: Dependency {
}

protocol CountryDetailsViewBuilder {
    func countryDetailsView(country: CountryEntity) -> CountryDetailsView
}

class CountryDetailsComponent: Component<CountryDetailsDependency>, CountryDetailsViewBuilder {

    var countryDetailsViewModel: CountryDetailsViewModel {
                return MainActor.assumeIsolated {
                    CountryDetailsViewModel(
            )
        }
    }
    
    func countryDetailsView(country: CountryEntity) -> CountryDetailsView {
        CountryDetailsView(viewModel: self.countryDetailsViewModel, country: country)
    }
}
