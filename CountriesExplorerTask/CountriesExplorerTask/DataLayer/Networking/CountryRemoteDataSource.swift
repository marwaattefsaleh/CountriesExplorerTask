//
//  CountryRemoteDataSource.swift
//  CountriesExplorerTask
//
//  Created by Marwa Attef on 07/11/2025.
//

import Foundation

protocol CountryRemoteDataSourceProtocol {
    func searchCountries(by name: String)  async throws -> [CountryDTO]
}

class CountryRemoteDataSource: CountryRemoteDataSourceProtocol {
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func searchCountries(by name: String) async throws -> [CountryDTO] {
        let response: [CountryDTO] = try await networkService.request(
            endpoint: "\(Constants.basePath)/name/\(name)",
            method: .get, parameters: nil, headers: nil
        )
        return response
    }
}
