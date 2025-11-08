//
//  NetworkError.swift
//  CountriesExplorerTask
//
//  Created by Marwa Attef on 06/11/2025.
//

import Foundation

enum NetworkError: LocalizedError, Equatable {
    case invalidURL
    case noInternet
    case unauthorized
    case notFound
    case serverError(message: String?)
    case decodingError
    case timedOut
    case unknownError(error: Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The request URL is invalid."
        case .noInternet:
            return "No internet connection. Please check your network."
        case .unauthorized:
            return "Unauthorized request. Please log in again."
        case .notFound:
            return "The requested resource was not found."
        case .serverError(let message):
            return message ?? "Server encountered an error."
        case .decodingError:
            return "Failed to decode server response."
        case .timedOut:
            return "The request timed out. Please try again."
        case .unknownError(let error):
            return "Unexpected error occurred: \(error.localizedDescription)"
        }
    }
    
    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
          switch (lhs, rhs) {
          case (.invalidURL, .invalidURL): return true
          case (.noInternet, .noInternet): return true
          case (.unauthorized, .unauthorized): return true
          case (.notFound, .notFound): return true
          case (.decodingError, .decodingError): return true
          case (.timedOut, .timedOut): return true
          case (.serverError(let lMsg), .serverError(let rMsg)):
              return lMsg == rMsg
          case (.unknownError, .unknownError):
              return true // cannot compare underlying error, just return true
          default:
              return false
          }
      }
}
