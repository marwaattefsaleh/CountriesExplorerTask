//
//  CountryDBModel.swift
//  CountriesExplorerTask
//
//  Created by Marwa Attef on 06/11/2025.
//

import Foundation
import SwiftData

@Model
final class CountryDBModel {
    // MARK: - Properties
    var name: String
    var capitalName: String?
    var flag: String?
    var currency: String?
    var cca2: String
    var population: Int?
    var region: String?
    var languages: String?
    var coordinates: String?
    
    // MARK: - Initializer
    init(
        name: String,
        capitalName: String? = nil,
        flag: String? = nil,
        currency: String? = nil,
        cca2: String,
        population: Int? = nil,
        region: String? = nil,
        languages: String? = nil,
        coordinates: String? = nil
    ) {
        self.name = name
        self.capitalName = capitalName
        self.flag = flag
        self.currency = currency
        self.cca2 = cca2
        self.population = population
        self.region = region
        self.languages = languages
        self.coordinates = coordinates
    }
}
extension CountryDBModel {
    func toEntity() -> CountryEntity {
        return CountryEntity(name: self.name, capitalName: self.capitalName, flag: self.flag, currency: self.currency, cca2: self.cca2, population: self.population, region: self.region, languages: self.languages, coordinates: self.coordinates)
    }
}
