//
//  CountryModelActor.swift
//  CountriesExplorerTask
//
//  Created by Marwa Attef on 07/11/2025.
//
import SwiftData
import Foundation

// MARK: - Country Model Actor
// Handles all SwiftData operations for CountryDBModel safely using @ModelActor.

@ModelActor
actor CountryModelActor {
    
    // MARK: - Save or Update Country
    /// Inserts or updates a CountryDBModel in the local database.
    /// - Parameter item: The country model to save.
    /// - Throws: DatabaseError.saveFailed for unexpected database errors.
    func saveOrUpdateCountry(_ item: CountryDBModel) throws {
        let code = item.cca2
        let descriptor = FetchDescriptor<CountryDBModel>(
            predicate: #Predicate { $0.cca2 == code }
        )
        
        do {
            let existing = try modelContext.fetch(descriptor).first
            if let existing = existing {
                existing.name = item.name
                existing.flag = item.flag
                existing.currency = item.currency
                existing.population = item.population
                existing.region = item.region
                existing.languages = item.languages
                existing.coordinates = item.coordinates
            } else {
                modelContext.insert(item)
            }
            try modelContext.save()
        } catch {
            throw DatabaseError.saveFailed(error)
        }
    }
    
    // MARK: - Delete Country
    /// Removes a country by its cca2 code.
    /// - Parameter code: Country cca2 code (e.g. "EG").
    /// - Throws: DatabaseError.notFound if country not found.
    /// - Throws: DatabaseError.deleteFailed if delete fails.
    func deleteCountry(by code: String) throws {
        let descriptor = FetchDescriptor<CountryDBModel>(
            predicate: #Predicate { $0.cca2 == code }
        )
        
        do {
            guard let country = try modelContext.fetch(descriptor).first else {
                throw DatabaseError.notFound
            }
            
            modelContext.delete(country)
            try modelContext.save()
        } catch let dbError as DatabaseError {
            throw dbError
        } catch {
            throw DatabaseError.deleteFailed(error)
        }
    }
    
    // MARK: - Get All Saved Countries
    /// Fetches all saved countries.
    /// - Throws: DatabaseError.fetchFailed if fetch fails.
    /// - Returns: Array of CountryEntity objects.
    func getAllCountries() throws -> [CountryEntity] {
        let descriptor = FetchDescriptor<CountryDBModel>()
        
        do {
            let results = try modelContext.fetch(descriptor)
            return results.map { $0.toEntity() }
        } catch {
            throw DatabaseError.fetchFailed(error)
        }
    }
    
    // MARK: - Get Country by Code
    /// Fetches a single country by its cca2 code (e.g. "EG").
    /// - Parameter cca2: The country code.
    /// - Throws: DatabaseError.notFound if the country doesn’t exist.
    /// - Throws: DatabaseError.fetchFailed if the fetch fails.
    /// - Returns: A CountryEntity representing the saved country.
    func getCountry(by cca2: String) throws -> CountryEntity {
        let descriptor = FetchDescriptor<CountryDBModel>(
            predicate: #Predicate { $0.cca2 == cca2 }
        )
        
        do {
            let results = try modelContext.fetch(descriptor)
            guard let country = results.first else {
                throw DatabaseError.notFound
            }
            return country.toEntity()
        } catch let dbError as DatabaseError {
            throw dbError
        } catch {
            throw DatabaseError.fetchFailed(error)
        }
    }
}
