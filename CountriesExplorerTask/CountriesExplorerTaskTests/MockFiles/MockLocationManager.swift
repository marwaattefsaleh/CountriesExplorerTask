//
//  MockLocationManager.swift
//  CountriesExplorerTask
//
//  Created by Marwa Attef on 08/11/2025.
//
@testable import CountriesExplorerTask
import Combine

// MARK: - Mock Location Manager
final class MockLocationManager: LocationManagerProtocol {
    let subject = CurrentValueSubject<String?, Never>(nil)
    var requestLocationCalled = false

    var currentCountryPublisher: AnyPublisher<String?, Never> {
        subject.eraseToAnyPublisher()
    }

    func requestUserLocation() {
        requestLocationCalled = true
    }
}
