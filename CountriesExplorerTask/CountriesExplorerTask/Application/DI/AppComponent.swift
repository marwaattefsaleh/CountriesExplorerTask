//
//  AppComponent.swift
//  CountriesExplorerTask
//
//  Created by Marwa Attef on 06/11/2025.
//
import NeedleFoundation
import SwiftData
import FirebaseCrashlytics

protocol FeatureBuilderProvidingProtocol {
    var HomeViewBuilder: HomeViewBuilder { get }
}

protocol AppComponentDependency: Dependency {}

class AppComponent: BootstrapComponent {
    var appConfiguration: AppConfigurationProtocol {
        shared { AppConfiguration() }
    }
   public var locationManager: LocationManagerProtocol {
          shared { LocationManager() }
      }
    var modelContainer: ModelContainer {
        shared {
            do {
                let schema = Schema([CountryDBModel.self])
                let container = try ModelContainer(for: schema)
                return container
            } catch {
                Crashlytics.crashlytics().log("Failed to create ModelContainer: \(error)")
                fatalError("Failed to create ModelContainer: \(error)")
            }
        }
    }
    
   public var countryModelActor: CountryModelActor {
        shared {
            CountryModelActor(modelContainer: modelContainer)
        }
    }
    public var networkService: NetworkServiceProtocol {
        NetworkService(config: appConfiguration)
    }

    var countryRemoteDataSource: CountryRemoteDataSourceProtocol {
        CountryRemoteDataSource(networkService: self.networkService)
    }
    var countryLocalDataSource: CountryLocalDataSourceProtocol {
        CountryLocalDataSource(actor: self.countryModelActor)
    }
    
    var experienceRepository: CountryRepositoryProtocol {
        CountryRepository(
            remoteDataSource: countryRemoteDataSource, localeDataSource: countryLocalDataSource)
    }
    
    public var searchCountriesUseCase: SearchCountriesUseCaseProtocol {
        return SearchCountriesUseCase(repository: experienceRepository)
    }
 
    public var getCountryUseCase: GetCountryUseCaseProtocol {
        return GetCountryUseCase(repository: experienceRepository)
    }
    
    public var deleteCountryUseCase: DeleteCountryUseCaseProtocol {
        return DeleteCountryUseCase(repository: experienceRepository)
    }
}

// Feature Builders
extension AppComponent: FeatureBuilderProvidingProtocol {
    var HomeViewBuilder: HomeViewBuilder {
         HomeComponent(parent: self)
     }
}
