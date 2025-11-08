//
//  MockDeleteCountryUseCase.swift
//  CountriesExplorerTask
//
//  Created by Marwa Attef on 08/11/2025.
//
import Foundation

@testable import CountriesExplorerTask


final class MockDeleteCountryUseCase: DeleteCountryUseCaseProtocol {
    var deletedCca2: String?
    var shouldThrowError = false
    var errorToThrow: Error = NSError(domain: "DeleteError", code: -1)

    func deleteCountry(by cca2: String) async throws {
        if shouldThrowError { throw errorToThrow }
        deletedCca2 = cca2
    }
}
