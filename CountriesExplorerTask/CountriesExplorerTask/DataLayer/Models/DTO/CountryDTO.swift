//
//  CountryDTO.swift
//  CountriesExplorerTask
//
//  Created by Marwa Attef on 06/11/2025.
//

import Foundation

struct CountryDTO: Decodable {
    let name: String
    let topLevelDomain: [String]?
    let alpha2Code: String
    let alpha3Code: String
    let callingCodes: [String]?
    let capital: String?
    let altSpellings: [String]?
    let subregion: String?
    let region: String?
    let population: Int?
    let latlng: [Double]?
    let demonym: String?
    let area: Double?
    let gini: Double?
    let timezones: [String]?
    let borders: [String]?
    let nativeName: String?
    let numericCode: String?
    let flags: FlagDTO?
    let currencies: [CurrencyDTO]?
    let languages: [LanguageDTO]?
    let translations: [String: String]?
    let flag: String?
    let regionalBlocs: [RegionalBlocDTO]?
    let cioc: String?
    let independent: Bool?
}

struct FlagDTO: Decodable {
    let svg: String
    let png: String
}

struct CurrencyDTO: Decodable {
    let code: String
    let name: String
    let symbol: String?
}

struct LanguageDTO: Decodable {
    let iso639_1: String?
    let iso639_2: String?
    let name: String
    let nativeName: String?
}

struct RegionalBlocDTO: Decodable {
    let acronym: String
    let name: String
    let otherNames: [String]?
}

extension CountryDTO {
    func toEntity() -> CountryEntity {
        return CountryEntity(name: self.name, capitalName: self.capital, flag: self.flags?.png, currency: self.currencies?.map { "\($0.code)(\($0.symbol ?? ""))" }.joined(separator: ", "), cca2: self.alpha2Code, population: self.population, region: self.region, languages: self.languages?.map { $0.name }.joined(separator: ", "), coordinates: latlng?.map { "\($0)" }.joined(separator: ", "))
    }
  
}
