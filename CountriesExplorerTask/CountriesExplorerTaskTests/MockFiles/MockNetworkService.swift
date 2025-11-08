//
//  MockNetworkService.swift
//  CountriesExplorerTask
//
//  Created by Marwa Attef on 08/11/2025.
//
import XCTest
@testable import CountriesExplorerTask
import Alamofire


// MARK: - Mock Network Service
final class MockNetworkService: NetworkServiceProtocol {
    var resultToReturn: Result<Data, Error>?
    
    func request<T>(endpoint: String,
                    method: HTTPMethod,
                    parameters: [String : Any]?,
                    headers: HTTPHeaders?) async throws -> T where T : Decodable {
        
        guard let result = resultToReturn else {
            fatalError("Mock result not set")
        }
        
        switch result {
        case .success(let data):
            return try JSONDecoder().decode(T.self, from: data)
        case .failure(let error):
            throw error
        }
    }
}

