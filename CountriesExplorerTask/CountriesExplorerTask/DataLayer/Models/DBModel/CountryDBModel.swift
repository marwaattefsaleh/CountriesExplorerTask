//
//  CountryDBModel.swift
//  CountriesExplorerTask
//
//  Created by Marwa Attef on 06/11/2025.
//

import Foundation
import SwiftData

@Model
final class CountryEntity {
    // MARK: - Properties
    var name: String
    var flag: String?
    var currency: String?
    var cca2: String
    var population: Int
    var region: String?
    var languages: [String]
    var coordinates: [Double]
    
    // MARK: - Initializer
    init(
        name: String,
        flag: String? = nil,
        currency: String? = nil,
        cca2: String,
        population: Int = 0,
        region: String? = nil,
        languages: [String] = [],
        coordinates: [Double] = []
    ) {
        self.name = name
        self.flag = flag
        self.currency = currency
        self.cca2 = cca2
        self.population = population
        self.region = region
        self.languages = languages
        self.coordinates = coordinates
    }
}
