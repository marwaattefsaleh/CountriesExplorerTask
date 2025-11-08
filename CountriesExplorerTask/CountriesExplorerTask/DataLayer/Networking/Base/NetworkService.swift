//
//  NetworkService.swift
//  CountriesExplorerTask
//
//  Created by Marwa Attef on 06/11/2025.
//

import Foundation
import Alamofire

protocol NetworkServiceProtocol {
    func request<T: Decodable>(
        endpoint: String,
        method: HTTPMethod,
        parameters: [String: Any]?,
        headers: HTTPHeaders?
    ) async throws -> T
}

class NetworkService: NetworkServiceProtocol {
    private let config: AppConfigurationProtocol
    private let session: Session

    init(config: AppConfigurationProtocol) {
        self.config = config
        let retrier = NetworkRequestRetrier()
        self.session = Session(interceptor: retrier)
    }

    func request<T: Decodable>(
        endpoint: String,
        method: HTTPMethod = .get,
        parameters: [String: Any]? = nil,
        headers: HTTPHeaders? = nil
    ) async throws -> T {
        
        guard let url = URL(string: config.baseURL + endpoint) else {
            throw NetworkError.invalidURL
        }

        let finalHeaders = headers ?? HTTPHeaders()
        let encoding: ParameterEncoding = method == .get ? URLEncoding.default : JSONEncoding.default

        let dataTask = session.request(
            url,
            method: method,
            parameters: parameters,
            encoding: encoding,
            headers: finalHeaders
        )

        let response = await dataTask.serializingData().response

        // Check HTTP status
        guard let statusCode = response.response?.statusCode else {
            
            if let urlError = response.error?.underlyingError as? URLError {
                   switch urlError.code {
                   case .notConnectedToInternet:
                       throw NetworkError.noInternet
                   case .timedOut:
                       throw NetworkError.timedOut
                   default:
                       throw NetworkError.unknownError(error: response.error ?? AFError.explicitlyCancelled)
                   }
               }
            
            throw NetworkError.unknownError(error: response.error ?? AFError.explicitlyCancelled)
        }

        switch statusCode {
        case 200...299:
            do {
                let decoded = try JSONDecoder().decode(T.self, from: response.data ?? Data())
                return decoded
            } catch {
                throw NetworkError.decodingError
            }

        case 401:
            throw NetworkError.unauthorized

        case 404:
            if let data = response.data,
               let apiError = try? JSONDecoder().decode(ErrorResponse.self, from: data),
               let message = apiError.message {
                throw NetworkError.serverError(message: message)
            } else {
                throw NetworkError.notFound
            }

        case 500...599:
            if let data = response.data,
               let apiError = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                throw NetworkError.serverError(message: apiError.message)
            } else {
                throw NetworkError.serverError(message: nil)
            }

        default:
            if let error = response.error {
                if error.isSessionTaskError {
                    throw NetworkError.noInternet
                } else if error.isResponseSerializationError {
                    throw NetworkError.decodingError
                } else {
                    throw NetworkError.unknownError(error: error)
                }
            } else {
                throw NetworkError.unknownError(error: NSError(domain: "Unknown", code: statusCode))
            }
        }
    }
}
