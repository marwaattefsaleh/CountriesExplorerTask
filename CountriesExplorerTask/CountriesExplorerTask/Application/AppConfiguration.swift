//
//  AppConfiguration.swift
//  CountriesExplorerTask
//
//  Created by Marwa Attef on 06/11/2025.
//

import Foundation
import NeedleFoundation

protocol AppConfigurationProtocol: AnyObject {
    var baseURL: String { get }
}

class AppConfiguration: AppConfigurationProtocol {
    // Computed property that reads the base URL from the app's Info.plist
    var baseURL: String {
        let urlString = Bundle.main.infoDictionary?[Constants.BaseUrlKey] as? String
        return urlString?.replacingOccurrences(of: "\\/", with: "/") ?? ""
    }
}
