//
//  DeleteCountryUseCase.swift
//  CountriesExplorerTask
//
//  Created by Marwa Attef on 07/11/2025.
//

protocol DeleteCountryUseCaseProtocol {
    func deleteCountry(by cca2: String) async throws
}

class DeleteCountryUseCase: DeleteCountryUseCaseProtocol {
    private let repository: CountryRepositoryProtocol
    
    init(repository: CountryRepositoryProtocol) {
        self.repository = repository
    }
  
    func deleteCountry(by cca2: String) async throws {
        try await self.repository.deleteCountryLocaly(by: cca2)
    }
}
