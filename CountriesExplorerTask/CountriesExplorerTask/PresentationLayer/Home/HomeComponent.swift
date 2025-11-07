//
//  HomeComponent.swift
//  CountriesExplorerTask
//
//  Created by Marwa Attef on 06/11/2025.
//
import NeedleFoundation

protocol HomeDependency: Dependency {
    var networkMonitor: NetworkMonitorProtocol { get }
    var getCountryUseCase: GetCountryUseCaseProtocol {get}
    var deleteCountryUseCase: DeleteCountryUseCaseProtocol {get}
    var locationManager: LocationManagerProtocol { get }
}

protocol HomeViewBuilder {
    var homeView: HomeView { get }
}

class HomeComponent: Component<HomeDependency>, HomeViewBuilder {
    
    var homeRouter: HomeRouter {
        HomeRouter(homeComponent: self)
    }
    
    var homeViewModel: HomeViewModel {
        let router = self.homeRouter
        let networkMonitor = self.networkMonitor
                return MainActor.assumeIsolated {
            HomeViewModel(
                deleteCountryUseCase: self.deleteCountryUseCase,
                    getCountryUseCase: self.getCountryUseCase,
                router: router,
                networkMonitor: networkMonitor,
                locationManager: self.locationManager

            )
        }
    }
    
    var homeView: HomeView {
        HomeView(viewModel: self.homeViewModel)
    }
    
    var countryDetailsViewBuilder: CountryDetailsViewBuilder {
       CountryDetailsComponent(parent: self)
    }
    
    var searchCountryViewBuilder: SearchCountryViewBuilder {
        SearchCountryComponent(parent: self)
    }
}
