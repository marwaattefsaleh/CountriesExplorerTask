//
//  LocationManager.swift
//  CountriesExplorerTask
//
//  Created by Marwa Attef on 08/11/2025.
//

import CoreLocation
import Combine

protocol LocationManagerProtocol {
    var currentCountryPublisher: AnyPublisher<String?, Never> { get }
    func requestUserLocation()
}

final class LocationManager: NSObject, LocationManagerProtocol, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()
    private let countrySubject = CurrentValueSubject<String?, Never>(nil)
    
    var currentCountryPublisher: AnyPublisher<String?, Never> {
        countrySubject.eraseToAnyPublisher()
    }
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func requestUserLocation() {
        let status = locationManager.authorizationStatus
        
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.requestLocation()
        default:
            // Permission denied → use default country
            countrySubject.send(Constants.defaultCountryCode)
        }
    }
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, _ in
            guard let countryCode = placemarks?.first?.isoCountryCode else {
                self?.countrySubject.send(Constants.defaultCountryCode)
                return
            }
            self?.countrySubject.send(countryCode)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        countrySubject.send(Constants.defaultCountryCode)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
            case .authorizedWhenInUse, .authorizedAlways:
                manager.requestLocation() // now permission is granted, request location
            case .denied, .restricted:
                countrySubject.send(Constants.defaultCountryCode) // fallback
            default:
                break
            }
    }
}
