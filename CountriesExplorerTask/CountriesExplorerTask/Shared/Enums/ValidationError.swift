//
//  ValidationError.swift
//  CountriesExplorerTask
//
//  Created by Marwa Attef on 07/11/2025.
//
import Foundation

enum ValidationError: LocalizedError {
    case limitExceeded(max: Int)
    case alreadyExist
    
    var errorDescription: String? {
        switch self {
        case .limitExceeded(let max):
            return "You can only save up to \(max) countries to your list."
            
        case .alreadyExist:
            return "Country already exists in your list."
        }
    }
}
