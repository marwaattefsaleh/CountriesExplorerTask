//
//  CountryDTO.swift
//  CountriesExplorerTask
//
//  Created by Marwa Attef on 06/11/2025.
//

import Foundation

// MARK: - CountryDTO
struct CountryDTO: Decodable {
    let name: CountryNameDTO
    let capital: [String]?
    let currencies: [String: CurrencyDTO]?
    let region: String?
    let subregion: String?
    let flags: CountryFlagDTO?
    let latlng: [Double]?
    let population: Int?
    let cca2: String?
}

// MARK: - CountryNameDTO
struct CountryNameDTO: Decodable {
    let common: String?
    let official: String?
}

// MARK: - CurrencyDTO
struct CurrencyDTO: Decodable {
    let symbol: String?
    let name: String?
}

// MARK: - CountryFlagDTO
struct CountryFlagDTO: Decodable {
    let png: String?
    let svg: String?
    let alt: String?
}
