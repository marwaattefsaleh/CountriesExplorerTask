//
//  CountryEntity.swift
//  CountriesExplorerTask
//
//  Created by Marwa Attef on 07/11/2025.
//

struct CountryEntity: Identifiable {
    var id: String { cca2 }
    var name: String
    var capitalName: String?
    var flag: String?
    var currency: String?
    var cca2: String
    var population: Int?
    var region: String?
    var languages: String?
    var coordinates: String?
    
    func toDBModel() -> CountryDBModel {
        return CountryDBModel(name: self.name, capitalName: self.capitalName, flag: self.flag, currency: self.currency, cca2: self.cca2, population: self.population, region: self.region, languages: self.languages, coordinates: self.coordinates)
    }
}
