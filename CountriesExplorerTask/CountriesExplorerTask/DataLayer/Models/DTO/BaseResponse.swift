//
//  BaseResponse.swift
//  CountriesExplorerTask
//
//  Created by Marwa Attef on 06/11/2025.
//
struct BaseResponse<T: Decodable>: Decodable {
    let data: T?
    let message: String?
    let status: Int?
}
