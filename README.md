# CountriesExplorerTask

<img width="200" height="500" alt="Simulator Screenshot - iPhone 16 Plus - 2025-11-08 at 06 43 30" src="https://github.com/user-attachments/assets/28d45c9a-a513-4a43-a99e-e9a1080d2bd2" />
<img width="200" height="500" alt="Simulator Screenshot - iPhone 16 Plus - 2025-11-08 at 06 43 43" src="https://github.com/user-attachments/assets/be3dfbb7-9de3-4523-bf94-1dd0a3b48853" />
<img width="200" height="500" alt="Simulator Screenshot - iPhone 16 Plus - 2025-11-08 at 06 43 48" src="https://github.com/user-attachments/assets/50191c83-0eee-468b-a56c-2cfdd8da36b3" />


---

## 🏗️ Architecture
The app follows **Clean Architecture** with the **MVVM pattern** and **Dependency Injection** using **NeedleFoundation**.

**Architecture Flow:**

View → ViewModel → UseCase → Repository → Data Sources (Remote / Local)

## 📁 Project Structure
```
CountriesExplorerTask/
├── Application/
│   ├── DI/
│   │   ├── AppComponent.swift
│   │   ├── AppConfiguration.swift
│   │   └── AppDelegate.swift
│   ├── CountriesExplorerTaskApp.swift
│   └── LocationManager.swift
├── DataLayer/
│   ├── Database/
│   │   ├── Base/
│   │   ├── CountryLocalDataSource.swift
│   │   └── CountryModelActor.swift
│   ├── Models/
│   │   ├── DBModel/
│   │   │   └── CountryDBModel.swift
│   │   └── DTO/
│   │       ├── CountryDTO.swift
│   │       └── ErrorResponse.swift
│   ├── Networking/
│   │   ├── Base/
│   │   │   ├── NetworkError.swift
│   │   │   ├── NetworkRequestRetrier.swift
│   │   │   └── NetworkService.swift
│   │   └── CountryRemoteDataSource.swift
│   └── Repository/
│       └── CountryRepository.swift
├── DomainLayer/
│   ├── Entities/
│   │   └── CountryEntity.swift
│   └── UseCases/
│       ├── DeleteCountryUseCase.swift
│       ├── GetCountryUseCase.swift
│       └── SearchCountriesUseCase.swift
└── PresentationLayer/
    ├── CountryDetails/
    │   ├── CountryDetailsComponent.swift
    │   ├── CountryDetailsView.swift
    │   └── CountryDetailsViewModel.swift
    ├── Home/
    │   ├── CountryItemView.swift
    │   ├── HomeComponent.swift
    │   ├── HomeRouter.swift
    │   ├── HomeView.swift
    │   └── HomeViewModel.swift
    ├── SearchCountry/
    │   ├── SearchCountryComponent.swift
    │   ├── SearchCountryView.swift
    │   ├── SearchCountryViewModel.swift
    │   ├── SearchItemShimmerView.swift
    │   └── SearchItemView.swift
    └── Shared/
        ├── Enums/
        │   └── ValidationError.swift
        ├── Extensions/
        │   ├── ColorExtension.swift
        │   ├── UIApplicationExtension.swift
        │   └── ViewExtension.swift
        └── Constants/
            └── Theme.swift
```

---

## ⚙️ Frameworks & Libraries

**Podfile dependencies:**

```ruby
pod 'Alamofire'                    # Networking
pod 'Firebase/Crashlytics'         # Crash reporting
pod 'SwiftLint'                    # Code style enforcement
pod 'NeedleFoundation'             # Dependency Injection
pod 'Kingfisher'                   # Image loading & caching
pod 'SwiftUI-Shimmer', :git => 'https://github.com/markiv/SwiftUI-Shimmer.git' # Loading animations
pod 'AlertToast'                   # Toast notifications
```

**Core Technologies:**
- SwiftUI – Declarative UI framework
- SwiftData – Local data persistence
- Async/Await – Modern concurrency
- MVVM – Architecture pattern
- Clean Architecture – Separation of concerns
- Needle – Compile-time safe Dependency Injection

## 📂 Layer Details

**Application Layer**
- AppComponent: Root dependency injection component
- NetworkMonitor: Real-time network connectivity monitoring
- AppDelegate: Firebase setup and app lifecycle management

**Domain Layer**
- Entities: Business model objects
- UseCases: Application business rules and operations

**Data Layer**
- Repository: Single source of truth for data
- RemoteDataSource: API communication layer
- LocalDataSource: SwiftData persistence layer
- ModelActor: Thread-safe SwiftData operations

**Presentation Layer**
- Views: SwiftUI screens and components
- ViewModels: Presentation logic and state management
- Components: Needle dependency components

## 🚀 Features
- **Country Search**: Allows searching for a country and fetching its capital city and currency.
- **Add Countries**: Enables adding up to 5 countries to the main view.
- **Country Details**: Displays the capital city and currency in a detailed view when selecting a country from the main view.
- **Automatic Location-Based Country**: Adds the first country to the main view based on the user's GPS location.
- **Default Country Fallback**: If the user denies location permission, a default country is used (never left empty).
- **Remove Countries**: Enable removing countries from the main view.
- **Unit Tests**: Comprehensive test coverage for the app's functionality
