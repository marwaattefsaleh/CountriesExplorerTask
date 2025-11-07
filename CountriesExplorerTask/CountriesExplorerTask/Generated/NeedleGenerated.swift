

import FirebaseCrashlytics
import NeedleFoundation
import SwiftData
import SwiftUI

// swiftlint:disable unused_declaration
private let needleDependenciesHash : String? = nil

// MARK: - Traversal Helpers

private func parent1(_ component: NeedleFoundation.Scope) -> NeedleFoundation.Scope {
    return component.parent
}

private func parent2(_ component: NeedleFoundation.Scope) -> NeedleFoundation.Scope {
    return component.parent.parent
}

// MARK: - Providers

#if !NEEDLE_DYNAMIC

private class HomeDependency443c4e1871277bd8432aProvider: HomeDependency {
    var networkMonitor: NetworkMonitorProtocol {
        return appComponent.networkMonitor
    }
    var getCountryUseCase: GetCountryUseCaseProtocol {
        return appComponent.getCountryUseCase
    }
    var deleteCountryUseCase: DeleteCountryUseCaseProtocol {
        return appComponent.deleteCountryUseCase
    }
    var locationManager: LocationManagerProtocol {
        return appComponent.locationManager
    }
    private let appComponent: AppComponent
    init(appComponent: AppComponent) {
        self.appComponent = appComponent
    }
}
/// ^->AppComponent->HomeComponent
private func factory67229cdf0f755562b2b1f47b58f8f304c97af4d5(_ component: NeedleFoundation.Scope) -> AnyObject {
    return HomeDependency443c4e1871277bd8432aProvider(appComponent: parent1(component) as! AppComponent)
}
private class SearchCountryDependencyb36ab6ff25e9aa2a936cProvider: SearchCountryDependency {
    var networkMonitor: NetworkMonitorProtocol {
        return appComponent.networkMonitor
    }
    var searchCountriesUseCase: SearchCountriesUseCaseProtocol {
        return appComponent.searchCountriesUseCase
    }
    private let appComponent: AppComponent
    init(appComponent: AppComponent) {
        self.appComponent = appComponent
    }
}
/// ^->AppComponent->HomeComponent->SearchCountryComponent
private func factory5069b4ce96375b8be5acb7304b634b3e62c64b3c(_ component: NeedleFoundation.Scope) -> AnyObject {
    return SearchCountryDependencyb36ab6ff25e9aa2a936cProvider(appComponent: parent2(component) as! AppComponent)
}
private class CountryDetailsDependencyaf318d611981b185d55bProvider: CountryDetailsDependency {
    var networkMonitor: NetworkMonitorProtocol {
        return appComponent.networkMonitor
    }
    private let appComponent: AppComponent
    init(appComponent: AppComponent) {
        self.appComponent = appComponent
    }
}
/// ^->AppComponent->HomeComponent->CountryDetailsComponent
private func factory2bbad96217cded030b99b7304b634b3e62c64b3c(_ component: NeedleFoundation.Scope) -> AnyObject {
    return CountryDetailsDependencyaf318d611981b185d55bProvider(appComponent: parent2(component) as! AppComponent)
}

#else
extension AppComponent: NeedleFoundation.Registration {
    public func registerItems() {

        localTable["locationManager-LocationManagerProtocol"] = { [unowned self] in self.locationManager as Any }
        localTable["countryModelActor-CountryModelActor"] = { [unowned self] in self.countryModelActor as Any }
        localTable["networkService-NetworkServiceProtocol"] = { [unowned self] in self.networkService as Any }
        localTable["networkMonitor-NetworkMonitorProtocol"] = { [unowned self] in self.networkMonitor as Any }
        localTable["searchCountriesUseCase-SearchCountriesUseCaseProtocol"] = { [unowned self] in self.searchCountriesUseCase as Any }
        localTable["getCountryUseCase-GetCountryUseCaseProtocol"] = { [unowned self] in self.getCountryUseCase as Any }
        localTable["deleteCountryUseCase-DeleteCountryUseCaseProtocol"] = { [unowned self] in self.deleteCountryUseCase as Any }
    }
}
extension HomeComponent: NeedleFoundation.Registration {
    public func registerItems() {
        keyPathToName[\HomeDependency.networkMonitor] = "networkMonitor-NetworkMonitorProtocol"
        keyPathToName[\HomeDependency.getCountryUseCase] = "getCountryUseCase-GetCountryUseCaseProtocol"
        keyPathToName[\HomeDependency.deleteCountryUseCase] = "deleteCountryUseCase-DeleteCountryUseCaseProtocol"
        keyPathToName[\HomeDependency.locationManager] = "locationManager-LocationManagerProtocol"

    }
}
extension SearchCountryComponent: NeedleFoundation.Registration {
    public func registerItems() {
        keyPathToName[\SearchCountryDependency.networkMonitor] = "networkMonitor-NetworkMonitorProtocol"
        keyPathToName[\SearchCountryDependency.searchCountriesUseCase] = "searchCountriesUseCase-SearchCountriesUseCaseProtocol"
    }
}
extension CountryDetailsComponent: NeedleFoundation.Registration {
    public func registerItems() {
        keyPathToName[\CountryDetailsDependency.networkMonitor] = "networkMonitor-NetworkMonitorProtocol"
    }
}


#endif

private func factoryEmptyDependencyProvider(_ component: NeedleFoundation.Scope) -> AnyObject {
    return EmptyDependencyProvider(component: component)
}

// MARK: - Registration
private func registerProviderFactory(_ componentPath: String, _ factory: @escaping (NeedleFoundation.Scope) -> AnyObject) {
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: componentPath, factory)
}

#if !NEEDLE_DYNAMIC

@inline(never) private func register1() {
    registerProviderFactory("^->AppComponent", factoryEmptyDependencyProvider)
    registerProviderFactory("^->AppComponent->HomeComponent", factory67229cdf0f755562b2b1f47b58f8f304c97af4d5)
    registerProviderFactory("^->AppComponent->HomeComponent->SearchCountryComponent", factory5069b4ce96375b8be5acb7304b634b3e62c64b3c)
    registerProviderFactory("^->AppComponent->HomeComponent->CountryDetailsComponent", factory2bbad96217cded030b99b7304b634b3e62c64b3c)
}
#endif

public func registerProviderFactories() {
#if !NEEDLE_DYNAMIC
    register1()
#endif
}
